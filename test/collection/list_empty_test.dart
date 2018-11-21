import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('empty list', () {
    test("has no elements", () {
      final empty = emptyList<String>();
      expect(empty.size, equals(0));
    });

    test("contains nothing", () {
      expect(emptyList<String>().contains("asdf"), isFalse);
      expect(emptyList<int>().contains(null), isFalse);
      expect(emptyList<int>().contains(0), isFalse);
      expect(emptyList<List>().contains([]), isFalse);
    });

    test("iterator has no next", () {
      final empty = emptyList();

      expect(empty.iterator().hasNext(), isFalse);
      expect(() => empty.iterator().next(), throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("is empty", () {
      final empty = emptyList();

      expect(empty.isEmpty(), isTrue);
    });

    test("throws when accessing an element", () {
      final empty = emptyList();

      expect(() => empty.get(0), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.get(1), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.get(-1), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.get(null), throwsA(TypeMatcher<ArgumentError>()));
    });

    test("indexOf always returns -1", () {
      final empty = emptyList();

      expect(empty.indexOf(""), equals(-1));
      expect(empty.indexOf([]), equals(-1));
      expect(empty.indexOf(0), equals(-1));
      expect(empty.indexOf(null), equals(-1));
    });

    test("is equals to another empty list", () {
      final empty0 = emptyList();
      final empty1 = emptyList();

      expect(empty0, equals(empty1));
      expect(empty0.hashCode, equals(empty1.hashCode));
    });

    test("empty lists of different type are equal", () {
      final empty0 = emptyList<int>();
      final empty1 = emptyList<String>();

      expect(empty0, equals(empty1));
      expect(empty0.hashCode, equals(empty1.hashCode));
    });

    test("is equals to another list without items", () {
      final empty0 = emptyList<String>();
      final empty1 = mutableListOf();

      expect(empty0.hashCode, equals(empty1.hashCode));
      expect(empty0, equals(empty1));
    });

    test("sublist works for index 0 to 0", () {
      final empty = emptyList<Object>();
      final subList = empty.subList(0, 0);
      expect(subList.size, equals(0));
      expect(subList, equals(empty));
    });

    test("sublist throws for all other ranges", () {
      final empty = emptyList<int>();

      expect(() => empty.subList(0, 1), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.subList(1, 1), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.subList(-1, -1), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.subList(2, 10), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
    });
  });
}
