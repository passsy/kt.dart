import 'package:kotlin_dart/collection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group("list", () {
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
            listOf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
        <T>([Iterable<T> iterable = const []]) => listFrom(iterable));
  });
  group("KtList", () {
    testList(
        <T>() => KtList<T>.empty(),
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
            KtList.of(
                arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
        <T>([Iterable<T> iterable = const []]) => KtList.from(iterable));
  });
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
        <T>([Iterable<T> iterable = const []]) => KtMutableList.from(iterable));
  });
}

void testList(
    KtList<T> Function<T>() emptyList,
    KtList<T> Function<T>(
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
        listOf,
    KtList<T> Function<T>([Iterable<T> iterable]) listFrom,
    {bool ordered = true}) {
  group("dropLast", () {
    test("drop last 3 items", () {
      final list = listOf(1, 2, 3, 4, 5, 6, 7);
      expect(list.dropLast(3), listOf(1, 2, 3, 4));
    });

    test("dropping from empty list drops nothing", () {
      expect(emptyList().dropLast(3), emptyList());
    });

    test("dropping more then list contains items results in empty list", () {
      final list = listOf(1, 2);
      expect(list.dropLast(3), emptyList());
    });

    test("drop number can't be null", () {
      final e = catchException<ArgumentError>(() => listFrom().dropLast(null));
      expect(e.message, allOf(contains("n "), contains("null")));
    });
  });

  group("dropLastWhile", () {
    test("drop last 3 items", () {
      final list = listOf(1, 2, 3, 4, 5, 6, 7);
      expect(list.dropLastWhile((i) => i >= 4), listOf(1, 2, 3, 4));
    });

    test("dropping from empty list drops nothing", () {
      expect(emptyList().dropLastWhile((_) => true), emptyList());
    });

    test("dropping nothing, keeps list as it is", () {
      final list = listOf(1, 2, 3, 4, 5);
      expect(list.dropLastWhile((_) => false), listOf(1, 2, 3, 4, 5));
    });

    test("dropping more then list contains items results in empty list", () {
      final list = listOf(1, 2);
      expect(list.dropLastWhile((_) => true), emptyList());
    });

    test("drop number can't be null", () {
      final e =
          catchException<ArgumentError>(() => listFrom().dropLastWhile(null));
      expect(e.message, allOf(contains("predicate"), contains("null")));
    });
  });

  group("foldRight", () {
    test("foldRight division", () {
      final iterable = listOf([1, 2], [3, 4], [5, 6]);
      final result = iterable.foldRight(
          listFrom<int>(), (it, KtList<int> acc) => acc + listFrom(it));
      expect(result, listOf(5, 6, 3, 4, 1, 2));
    });

    test("operation must be non null", () {
      final e = catchException<ArgumentError>(
          () => emptyList().foldRight("foo", null));
      expect(e.message, allOf(contains("null"), contains("operation")));
    });
  });

  group("foldRightIndexed", () {
    test("foldRightIndexed division", () {
      final iterable = listOf([1, 2], [3, 4], [5, 6]);
      var i = 2;
      final result = iterable.foldRightIndexed(listFrom<int>(),
          (index, it, KtList<int> acc) {
        expect(index, i);
        i--;
        return acc + listFrom(it);
      });
      expect(result, listOf(5, 6, 3, 4, 1, 2));
    });

    test("operation must be non null", () {
      final e = catchException<ArgumentError>(
          () => emptyList().foldRightIndexed("foo", null));
      expect(e.message, allOf(contains("null"), contains("operation")));
    });
  });

  group("first", () {
    test("get first element", () {
      expect(listOf("a", "b").first(), "a");
    });

    test("first throws for no elements", () {
      expect(() => emptySet().first(),
          throwsA(TypeMatcher<NoSuchElementException>()));
      expect(() => listFrom().first(),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("finds nothing throws", () {
      expect(() => setOf<String>("a").first((it) => it == "b"),
          throwsA(TypeMatcher<NoSuchElementException>()));
      expect(() => listOf("a").first((it) => it == "b"),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });
  });

  group("getOrElse", () {
    test("get item", () {
      final list = listOf("a", "b", "c");
      final item = list.getOrElse(1, (_) => "asdf");
      expect(item, "b");
    });
    test("get else", () {
      final list = listOf("a", "b", "c");
      final item = list.getOrElse(-1, (_) => "asdf");
      expect(item, "asdf");
    });
    test("else index is correct", () {
      final list = listOf("a", "b", "c");
      final item = list.getOrElse(5, (i) => "index: 5");
      expect(item, "index: 5");
    });
    test("index can't be null", () {
      final e = catchException<ArgumentError>(
          () => listFrom().getOrElse(null, (_) => "asdf"));
      expect(e.message, allOf(contains("null"), contains("index")));
    });
    test("defaultValue function can't be null", () {
      final e =
          catchException<ArgumentError>(() => listFrom().getOrElse(1, null));
      expect(e.message, allOf(contains("null"), contains("defaultValue")));
    });
  });

  group("getOrNull", () {
    test("get item", () {
      final list = listOf("a", "b", "c");
      final item = list.getOrNull(1);
      expect(item, "b");
    });
    test("get else", () {
      final list = listOf("a", "b", "c");
      final item = list.getOrNull(-1);
      expect(item, isNull);
    });
    test("index can't be null", () {
      final e = catchException<ArgumentError>(() => listFrom().getOrNull(null));
      expect(e.message, allOf(contains("null"), contains("index")));
    });
  });

  group("slice", () {
    test("slice", () {
      final list = listOf(1, 2, 3, 4, 5, 6, 7, 8, 9);
      final result = list.slice(listOf(4, 6, 8));
      expect(result, listOf(5, 7, 9));
    });
    test("slice with empty list results in empty list", () {
      final list = listOf(1, 2, 3, 4, 5, 6, 7, 8, 9);
      final result = list.slice(emptyList());
      expect(result, emptyList());
    });
    test("indices can't be null", () {
      final e = catchException<ArgumentError>(() => listFrom().slice(null));
      expect(e.message, allOf(contains("null"), contains("indices")));
    });
    test("check upper bounds", () {
      final e = catchException<IndexOutOfBoundsException>(
          () => listOf(1, 2, 3).slice(listOf(3)));
      expect(e.message, allOf(contains("size: 3"), contains("index: 3")));
    });
    test("check lower bounds", () {
      final e = catchException<IndexOutOfBoundsException>(
          () => listOf(1, 2, 3).slice(listOf(-1)));
      expect(e.message, allOf(contains("size: 3"), contains("index: -1")));
    });
  });
}
