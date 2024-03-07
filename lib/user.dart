// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//
import 'package:macros_example/json_serializable.dart';

void main() {
  print(User.fromJson({'name': 'jack', 'age': 1}).name);
}

@JsonSerializable()
class User {
  final int age;
  final String name;
}

@JsonSerializable()
class UserAccount extends User {
  final Login login;
}

@JsonSerializable()
class Login {
  final String username;
  final String password;
}
