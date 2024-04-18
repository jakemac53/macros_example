import 'package:test/test.dart';
import 'package:macros_example/auto_to_string.dart';

@AutoToString()
class TheClass {
  static String staticField = 'static';
  final int number;
  String? text;
  List<String> texts;
  TheClass({required this.number, this.text, this.texts = const <String>[]});
}

@AutoToString()
class LinkedList {
  static const LinkedList? nil = null;
  final String value;
  final LinkedList? next;
  LinkedList(this.value, [this.next]);
}

void main() {
  test('all fields', () {
    var instance =
        TheClass(number: 42, text: 'text', texts: ['text1', 'text2']);
    var toString = instance.toString();
    expect(toString, isNot('[Instance of TheClass]'));
    expect(toString, startsWith('TheClass'));
    expect(toString, contains('number: 42\n'));
    expect(toString, contains('text: text\n'));
    expect(toString, contains('texts: [text1, text2]\n'));
    expect(toString, isNot(contains('static')));
  });
  test('nullable fields', () {
    var instance = TheClass(number: 42, texts: ['text1', 'text2']);
    var toString = instance.toString();
    expect(toString, isNot('[Instance of TheClass]'));
    expect(toString, startsWith('TheClass'));
    expect(toString, contains('number: 42\n'));
    expect(toString, contains('text: null\n'));
    expect(toString, contains('texts: [text1, text2]\n'));
    expect(toString, isNot(contains('static')));
  });
  test('self reference', () {
    var list = LinkedList('a', LinkedList('b', LinkedList('c')));
    var toString = list.toString();
    expect(toString, isNot('[Instance of LinkedList]'));
    expect(toString, startsWith('LinkedList'));
    expect(toString, contains('value: a\n'));
    expect(toString, contains('value: b\n'));
    expect(toString, contains('value: c\n'));
    expect(toString, contains('next: LinkedList'));
    expect(toString, contains('next: null'));
    expect(toString, isNot(contains('nil')));
  });
}
