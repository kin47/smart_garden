import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CI Tests', () {
    test('Basic arithmetic test', () {
      expect(1 + 1, equals(2));
      expect(2 * 3, equals(6));
      expect(10 - 5, equals(5));
    });

    test('String operations test', () {
      expect('Hello'.length, equals(5));
      expect('World'.toUpperCase(), equals('WORLD'));
      expect('Flutter'.contains('utter'), isTrue);
    });

    test('List operations test', () {
      final list = [1, 2, 3, 4, 5];
      expect(list.length, equals(5));
      expect(list.first, equals(1));
      expect(list.last, equals(5));
      expect(list.contains(3), isTrue);
    });
  });
} 