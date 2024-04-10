import 'package:macros_example/auto_to_string.dart';

void main() {
  final jack = User('Jack', 25);
  print(jack.toString());
}

@AutoToString()
class User {
  final String name;
  final int age;

  User(this.name, this.age);
}
