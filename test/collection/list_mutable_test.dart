import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("mutableList", () {
    testList(
        <T>() => emptyList<T>(),
        <T>(
                [T arg0,
                T arg1,
                T arg2,
                T arg3,
                T arg4,
                T arg5,
                T arg6,
                T arg7,
                T arg8,
                T arg9]) =>
            mutableListOf(
                arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
        <T>([Iterable<T> iterable = const []]) => mutableListFrom(iterable));
  });
  group("KtMutableList", () {
    testList(
        <T>() => KtMutableList<T>.empty(),
        <T>(
                [T arg0,
                T arg1,
                T arg2,
                T arg3,
                T arg4,
                T arg5,
                T arg6,
                T arg7,
                T arg8,
                T arg9]) =>
            KtMutableList.of(
                arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
        <T>([Iterable<T> iterable = const []]) => KtMutableList.from(iterable));
  });
}

void testList(
    KtMutableList<T> Function<T>() emptyList,
    KtMutableList<T> Function<T>(
            [T arg0,
            T arg1,
            T arg2,
            T arg3,
            T arg4,
            T arg5,
            T arg6,
            T arg7,
            T arg8,
            T arg9])
        mutableListOf,
    KtMutableList<T> Function<T>([Iterable<T> iterable]) mutableListFrom,
    {bool ordered = true}) {
  group("basic methods", () {
    test("has no elements", () {
      final list = mutableListOf();
      expect(list.size, equals(0));
    });

    test("contains nothing", () {
      final list = mutableListOf("a", "b", "c");
      expect(list.contains("a"), isTrue);
      expect(list.contains("b"), isTrue);
      expect(list.contains("c"), isTrue);
      expect(list.contains(null), isFalse);
      expect(list.contains(""), isFalse);
      expect(list.contains(null), isFalse);
    });

    test("iterator with 1 element has 1 next", () {
      final list = mutableListOf("a");
      final iterator = list.iterator();
      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), equals("a"));

      expect(iterator.hasNext(), isFalse);
      expect(() => iterator.next(),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("is list", () {
      final list = mutableListOf("asdf");

      expect(list.isEmpty(), isFalse);
      expect(list.isEmpty(), isFalse);
    });

    test("get returns elements", () {
      final list = mutableListOf("a", "b", "c");

      expect(list.get(0), equals("a"));
      expect(list.get(1), equals("b"));
      expect(list.get(2), equals("c"));
      expect(() => list.get(3),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.get(-1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.get(null), throwsA(const TypeMatcher<ArgumentError>()));
    });

    test("[] returns elements", () {
      final list = mutableListOf("a", "b", "c");

      expect(list[0], equals("a"));
      expect(list[1], equals("b"));
      expect(list[2], equals("c"));
      expect(() => list[3],
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list[-1],
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list[null], throwsA(const TypeMatcher<ArgumentError>()));
    });

    test("indexOf return element or -1", () {
      final list = mutableListOf("a", "b", "c");

      expect(list.indexOf(""), equals(-1));
      expect(list.indexOf("a"), equals(0));
      expect(list.indexOf("b"), equals(1));
      expect(list.indexOf("c"), equals(2));
      expect(list.indexOf("d"), equals(-1));
      expect(list.indexOf(null), equals(-1));
    });

    test("is equals to another list list", () {
      final list0 = mutableListOf("a", "b", "c");
      final list1 = mutableListOf("a", "b", "c");
      final list2 = mutableListOf("a", "c");

      expect(list0, equals(list1));
      expect(list0.hashCode, equals(list1.hashCode));

      expect(list0, isNot(equals(list2)));
      expect(list0.hashCode, isNot(equals(list2.hashCode)));
    });

    test("set", () {
      final list = mutableListOf(1, 2, 3, 4, 5);
      list.set(2, 10);
      expect(list, listOf(1, 2, 10, 4, 5));
      list.set(0, 4);
      expect(list, listOf(4, 2, 10, 4, 5));
      list.set(4, 1);
      expect(list, listOf(4, 2, 10, 4, 1));
    });

    test("set doesn't allow null as index", () {
      final e = catchException<ArgumentError>(
          () => mutableListOf().set(null, "test"));
      expect(e.message, allOf(contains("null"), contains("index")));
    });

    test("set operator", () {
      final list = mutableListOf(1, 2, 3, 4, 5);
      list[2] = 10;
      expect(list, listOf(1, 2, 10, 4, 5));
      list[0] = 4;
      expect(list, listOf(4, 2, 10, 4, 5));
      list[4] = 1;
      expect(list, listOf(4, 2, 10, 4, 1));
    });

    test("sublist works ", () {
      final list = mutableListOf("a", "b", "c");
      final subList = list.subList(1, 3);
      expect(subList, equals(mutableListOf("b", "c")));
    });

    test("sublist doesn't allow null as fromIndex", () {
      final e = catchException<ArgumentError>(
          () => mutableListOf().subList(null, 10));
      expect(e.message, allOf(contains("null"), contains("fromIndex")));
    });

    test("sublist doesn't allow null as toIndex", () {
      final e =
          catchException<ArgumentError>(() => mutableListOf().subList(0, null));
      expect(e.message, allOf(contains("null"), contains("toIndex")));
    });

    test("sublist throws for illegal ranges", () {
      final list = mutableListOf("a", "b", "c");

      expect(() => list.subList(0, 10),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.subList(6, 10),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.subList(-1, -1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.subList(3, 1),
          throwsA(const TypeMatcher<ArgumentError>()));
      expect(() => list.subList(2, 10),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
    });

    test("add item appends item to end", () {
      final list = mutableListFrom<String>(["World"]);
      list.add("Hello");
      expect(list, listOf("World", "Hello"));
    });

    test("addAt to specific position (first)", () {
      final list = mutableListFrom<String>(["World"]);
      list.addAt(0, "Hello");
      expect(list, listOf("Hello", "World"));
    });

    test("addAt to specific position (last)", () {
      final list = mutableListFrom<String>(["World"]);
      list.addAt(1, "Hello");
      expect(list, listOf("World", "Hello"));
    });

    test("addAt doens't allow null as index", () {
      final e = catchException<ArgumentError>(
          () => mutableListOf().addAt(null, listOf("test")));
      expect(e.message, allOf(contains("null"), contains("index")));
    });

    test("addAll add items at the end of the list", () {
      final list = mutableListOf("a");
      list.addAll(listOf("b", "c"));
      expect(list.size, equals(3));
      expect(list, equals(listOf("a", "b", "c")));
    });

    test("addAllAt 0 add items at the beginning of the list", () {
      final list = mutableListOf("a");
      list.addAllAt(0, listOf("b", "c"));
      expect(list.size, equals(3));
      expect(list, equals(listOf("b", "c", "a")));
    });

    test("addAllAt doens't allow null as index", () {
      final e = catchException<ArgumentError>(
          () => mutableListOf().addAllAt(null, listOf("test")));
      expect(e.message, allOf(contains("null"), contains("index")));
    });

    test("addAllAt doens't allow null as elements", () {
      final e = catchException<ArgumentError>(
          () => mutableListOf().addAllAt(0, null));
      expect(e.message, allOf(contains("null"), contains("elements")));
    });

    test("listIterator requires int as index", () {
      final e = catchException<ArgumentError>(
          () => mutableListOf("a", "b", "c").listIterator(null));
      expect(e.message, allOf(contains("null"), contains("index")));
    });

    test("equals although differnt types (subtypes)", () {
      expect(mutableListOf<int>(1, 2, 3), mutableListOf<num>(1, 2, 3));
      expect(mutableListOf<num>(1, 2, 3), mutableListOf<int>(1, 2, 3));
      expect(linkedSetOf<int>(1, 2, 3), linkedSetOf<num>(1, 2, 3));
      expect(linkedSetOf<num>(1, 2, 3), linkedSetOf<int>(1, 2, 3));
    });
  });
}
