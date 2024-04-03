// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:macros/macros.dart';

/// A macro that annotates a function, which becomes the build method for a
/// generated stateless widget.
///
/// The function must have at least one positional parameter, which is of type
/// BuildContext (and this must be the first parameter).
///
/// Any additional function parameters are turned into fields on the stateless
/// widget.
macro class FunctionalWidget implements FunctionTypesMacro {
  final Identifier? widgetIdentifier;

  const FunctionalWidget(
      {
      // Defaults to removing the leading `_` from the function name and calling
      // `toUpperCase` on the next character.
      this.widgetIdentifier});

  @override
  Future<void> buildTypesForFunction(
      FunctionDeclaration function, TypeBuilder builder) async {
    if (!function.identifier.name.startsWith('_')) {
      throw DiagnosticException(Diagnostic(
          DiagnosticMessage(
              'FunctionalWidget should only be used on private declarations',
              target: function.asDiagnosticTarget),
          Severity.error));
    }
    if (function.positionalParameters.isEmpty ||
        // TODO: A proper type check here.
        (function.positionalParameters.first.type as NamedTypeAnnotation)
                .identifier
                .name !=
            'BuildContext') {
      throw DiagnosticException(Diagnostic(
          DiagnosticMessage(
              'FunctionalWidget functions must have a BuildContext argument as the '
              'first positional argument',
              target: function.positionalParameters.isEmpty
                  ? function.asDiagnosticTarget
                  : function.positionalParameters.first.asDiagnosticTarget),
          Severity.error));
    }

    var widgetName = widgetIdentifier?.name ??
        function.identifier.name
            .replaceRange(0, 2, function.identifier.name[1].toUpperCase());
    var positionalFieldParams = function.positionalParameters.skip(1);
    // ignore: deprecated_member_use
    var statelessWidget = await builder.resolveIdentifier(
        Uri.parse('package:flutter/src/widgets/framework.dart'),
        'StatelessWidget');
    // ignore: deprecated_member_use
    var buildContext = await builder.resolveIdentifier(
        Uri.parse('package:flutter/src/widgets/framework.dart'),
        'BuildContext');
    // ignore: deprecated_member_use
    var widget = await builder.resolveIdentifier(
        Uri.parse('package:flutter/src/widgets/framework.dart'), 'Widget');
    var override =
        // ignore: deprecated_member_use
        await builder.resolveIdentifier(Uri.parse('dart:core'), 'override');
    builder.declareType(
        widgetName,
        DeclarationCode.fromParts([
          'class $widgetName extends ', statelessWidget, ' {\n',
          // Fields
          for (var param
              in positionalFieldParams.followedBy(function.namedParameters))
            DeclarationCode.fromParts([
              '  final ',
              param.type.code,
              ' ',
              param.identifier.name,
              ';\n',
            ]),
          // Constructor
          '  const $widgetName(',
          for (var param in positionalFieldParams)
            'this.${param.identifier.name}, ',
          '{',
          for (var param in function.namedParameters)
            '${param.isRequired ? 'required ' : ''}this.${param.identifier.name}, ',
          'super.key,',
          '});\n',
          // Build method
          '  @', override, '\n  ',
          widget,
          ' build(',
          buildContext,
          ' context) => \n    ',
          // TODO: https://github.com/dart-lang/sdk/issues/55329
          function.identifier.name,
          '(context, ',
          for (var param in positionalFieldParams) '${param.identifier.name}, ',
          for (var param in function.namedParameters)
            '${param.identifier.name}: ${param.identifier.name}, ',
          ');',
          '\n}',
        ]));
  }
}
