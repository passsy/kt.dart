import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('basic methods', () {
    test("empty iterator", () {
      var iterator = setOf().iterator();
      expect(iterator.hasNext(), isFalse);
      expect(() => iterator.next(), throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("has no elements", () {
      final set = setOf([]);
      expect(set.size, equals(0));
    });

    test("contains nothing", () {
      final set = setOf(["a", "b", "c"]);
      expect(set.contains("a"), isTrue);
      expect(set.contains("b"), isTrue);
      expect(set.contains("c"), isTrue);
      expect(set.contains(null), isFalse);
      expect(set.contains(""), isFalse);
      expect(set.contains(null), isFalse);
    });

    test("empty iterator has no next", () {
      final set = setOf();
      final iterator = set.iterator();
      expect(iterator.hasNext(), isFalse);
      expect(() => iterator.next(), throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("iterator with 1 element has 1 next", () {
      final set = setOf(["a"]);
      final iterator = set.iterator();
      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), equals("a"));

      expect(iterator.hasNext(), isFalse);
      expect(() => iterator.next(), throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("iterator with items", () {
      var iterator = setOf([1, 2, 3]).iterator();

      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), isNotNull);
      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), isNotNull);

      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), isNotNull);

      expect(iterator.hasNext(), isFalse);
      expect(() => iterator.next(), throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("is empty", () {
      final set = setOf(["asdf"]);

      expect(set.isEmpty(), isFalse);
      expect(set.isEmpty(), isFalse);
    });

    test("is equal to another set", () {
      final set0 = setOf(["a", "b", "c"]);
      final set1 = setOf(["b", "a", "c"]);
      final set2 = setOf(["a", "c"]);
      final set3 = setOf([]);

      expect(set0, equals(set1));
      expect(set0.hashCode, equals(set1.hashCode));

      expect(set0, isNot(equals(set2)));
      expect(set0.hashCode, isNot(equals(set2.hashCode)));

      expect(set0, isNot(equals(set3)));
    });
  });
}
