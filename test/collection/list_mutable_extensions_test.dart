import "dart:math";

import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("KtMutableListExtensions", () {
    group("mutableList", () {
      testList(
          <T>() => mutableListOf<T>(),
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
          <T>([Iterable<T> iterable = const []]) =>
              KtMutableList.from(iterable));
    });
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
  group("clear", () {
    test("clear list", () {
      final list = mutableListOf("a", "b", "c");
      expect(list.size, 3);
      list.clear();
      expect(list.size, 0);
    });
    test("clear empty list", () {
      final list = mutableListOf();
      expect(list.size, 0);
      list.clear();
      expect(list.size, 0);
    });
  });

  group("fill", () {
    test("replace all elements", () {
      final list = mutableListOf("a", "b", "c");
      list.fill("x");
      expect(list, listOf("x", "x", "x"));
    });

    test("on empty list", () {
      final list = mutableListFrom<String>([]);
      list.fill("x");
      expect(list, emptyList());
    });
  });

  group("removeAt", () {
    test("index can't be null", () {
      final e =
          catchException<ArgumentError>(() => mutableListOf().removeAt(null));
      expect(e.message, allOf(contains("null"), contains("index")));
    });

    test("removes item at index", () {
      final list = mutableListOf("a", "b", "c");
      list.removeAt(1);
      expect(list, listOf("a", "c"));
    });

    test("removeAt throw for indexes greater size", () {
      final list = mutableListOf("a", "b", "c");
      final e =
          catchException<IndexOutOfBoundsException>(() => list.removeAt(-1));
      expect(e.message, allOf(contains("3"), contains("")));
    });

    test("removeAt throw for indexes below 0", () {
      final list = mutableListOf("a", "b", "c");
      final e =
          catchException<IndexOutOfBoundsException>(() => list.removeAt(-1));
      expect(e.message, allOf(contains("-1"), contains("")));
    });
  });

  group("sorted", () {
    String lastChar(String it) {
      final last = it.runes.last;
      return String.fromCharCode(last);
    }

    test("sortBy", () {
      final result = mutableListOf("paul", "john", "max", "lisa")
        ..sortBy(lastChar);
      expect(result, listOf("lisa", "paul", "john", "max"));
    });

    test("sortBy doesn't allow null as argument", () {
      const num Function(dynamic) selector = null;
      final e = catchException<ArgumentError>(
          () => mutableListOf<String>()..sortBy(selector));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });

    test("sortByDescending", () {
      final result = mutableListOf("paul", "john", "max", "lisa")
        ..sortByDescending(lastChar);
      expect(result, listOf("max", "john", "paul", "lisa"));
    });

    test("sortByDescending doesn't allow null as argument", () {
      const num Function(dynamic) selector = null;
      final e = catchException<ArgumentError>(
          () => mutableListOf<String>()..sortByDescending(selector));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });

    test("sortWith doesn't allow null as argument", () {
      final e = catchException<ArgumentError>(
          () => mutableListOf<String>()..sortWith(null));
      expect(e.message, allOf(contains("null"), contains("comparator")));
    });
  });

  group("shuffle", () {
    test("shuffle shuffles items in a list with provided Random object", () {
      final firstList = mutableListOf(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
      firstList.shuffle(Random(1));
      final secondList = mutableListOf(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
      secondList.shuffle(Random(2));
      expect(firstList, isNot(equals(secondList)));
    });
  });
}
