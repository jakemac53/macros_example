// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:macros_example/user.dart';

void main() {
  var jack = User.fromJson({'name': 'Jack', 'age': 10});
  document.body!.text = 'Hi, its ${jack.name}!';
}
