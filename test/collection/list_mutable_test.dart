import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('basic methods', () {
    test("has no elements", () {
      final list = mutableListOf([]);
      expect(list.size, equals(0));
    });

    test("contains nothing", () {
      final list = mutableListOf(["a", "b", "c"]);
      expect(list.contains("a"), isTrue);
      expect(list.contains("b"), isTrue);
      expect(list.contains("c"), isTrue);
      expect(list.contains(null), isFalse);
      expect(list.contains(""), isFalse);
      expect(list.contains(null), isFalse);
    });

    test("iterator with 1 element has 1 next", () {
      final list = mutableListOf(["a"]);
      final iterator = list.iterator();
      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), equals("a"));

      expect(iterator.hasNext(), isFalse);
      expect(() => iterator.next(), throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("is list", () {
      final list = mutableListOf(["asdf"]);

      expect(list.isEmpty(), isFalse);
      expect(list.isEmpty(), isFalse);
    });

    test("get returns elements", () {
      final list = mutableListOf(["a", "b", "c"]);

      expect(list.get(0), equals("a"));
      expect(list.get(1), equals("b"));
      expect(list.get(2), equals("c"));
      expect(() => list.get(3), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.get(-1), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.get(null), throwsA(TypeMatcher<ArgumentError>()));
    });

    test("[] returns elements", () {
      final list = mutableListOf(["a", "b", "c"]);

      expect(list[0], equals("a"));
      expect(list[1], equals("b"));
      expect(list[2], equals("c"));
      expect(() => list[3], throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list[-1], throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list[null], throwsA(TypeMatcher<ArgumentError>()));
    });

    test("indexOf return element or -1", () {
      final list = mutableListOf(["a", "b", "c"]);

      expect(list.indexOf(""), equals(-1));
      expect(list.indexOf("a"), equals(0));
      expect(list.indexOf("b"), equals(1));
      expect(list.indexOf("c"), equals(2));
      expect(list.indexOf("d"), equals(-1));
      expect(list.indexOf(null), equals(-1));
    });

    test("is equals to another list list", () {
      final list0 = mutableListOf(["a", "b", "c"]);
      final list1 = mutableListOf(["a", "b", "c"]);
      final list2 = mutableListOf(["a", "c"]);

      expect(list0, equals(list1));
      expect(list0.hashCode, equals(list1.hashCode));

      expect(list0, isNot(equals(list2)));
      expect(list0.hashCode, isNot(equals(list2.hashCode)));
    });

    test("sublist works ", () {
      final list = mutableListOf(["a", "b", "c"]);
      final subList = list.subList(1, 3);
      expect(subList, equals(mutableListOf(["b", "c"])));
    });

    test("sublist throws for illegal ranges", () {
      final list = mutableListOf(["a", "b", "c"]);

      expect(() => list.subList(0, 10), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.subList(6, 10), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.subList(-1, -1), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.subList(3, 1), throwsA(TypeMatcher<ArgumentError>()));
      expect(() => list.subList(2, 10), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
    });

    test("add item", () {
      final list = mutableListOf<String>();
      list.add("Hello");
      expect(list.size, equals(1));
      expect(list[0], equals("Hello"));
    });

    test("addAll add items at the end of the lsit", () {
      final list = mutableListOf(["a"]);
      list.addAll(listOf(["b", "c"]));
      expect(list.size, equals(3));
      expect(list, equals(listOf(["a", "b", "c"])));
    });
  });
}
