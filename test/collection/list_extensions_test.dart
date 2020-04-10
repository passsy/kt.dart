import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("KtListExtensions", () {
    group("list", () {
      testList(emptyList, listOf, listFrom);
    });
    group("mutableList", () {
      testList(<T>() => KtMutableList.empty(), mutableListOf, mutableListFrom,
          mutable: true);
    });
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
  KtList<T> Function<T>([Iterable<T> iterable]) listFrom, {
  bool mutable = false,
}) {
  group("dart property", () {
    if (mutable) {
      test("dart property is mutating original collection", () {
        final original = listFrom<String>(["a", "b", "c"]);
        final dartList = original.dart;
        dartList.add("x");
        expect(dartList, ["a", "b", "c", "x"]);
        expect(original, listOf("a", "b", "c", "x"));
      });
    } else {
      test("dart property returns an unmodifiable list", () {
        final dartList = listFrom<String>(["a", "b", "c"]).dart;
        final e = catchException<UnsupportedError>(() => dartList.add("x"));
        expect(e.message, contains("unmodifiable"));
      });
    }
  });

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
      expect(list.dropLastWhile((i) => i >= 4), listOf(1, 2, 3));
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

  group("elementAt", () {
    test("returns correct elements", () {
      final iterable = listOf("a", "b", "c");
      expect(iterable.elementAt(0), equals("a"));
      expect(iterable.elementAt(1), equals("b"));
      expect(iterable.elementAt(2), equals("c"));
    });

    test("throws out of bounds exceptions", () {
      final list = listOf("a", "b", "c");
      final eOver =
          catchException<IndexOutOfBoundsException>(() => list.elementAt(3));
      expect(eOver.message, allOf(contains("index"), contains("3")));

      final eUnder =
          catchException<IndexOutOfBoundsException>(() => list.elementAt(-1));
      expect(eUnder.message, allOf(contains("index"), contains("-1")));
    });

    test("null is not a valid index", () {
      final list = listOf("a", "b", "c");
      final e = catchException<ArgumentError>(() => list.elementAt(null));
      expect(e.message, allOf(contains("index"), contains("null")));
    });
  });

  group("elementAtOrElse", () {
    test("returns correct elements", () {
      final list = listOf("a", "b", "c");
      expect(list.elementAtOrElse(0, (i) => "x"), equals("a"));
      expect(list.elementAtOrElse(1, (i) => "x"), equals("b"));
      expect(list.elementAtOrElse(2, (i) => "x"), equals("c"));
    });

    test("returns else case", () {
      final list = listOf("a", "b", "c");
      expect(list.elementAtOrElse(-1, (i) => "x"), equals("x"));
    });

    test("returns else case based on index", () {
      final list = listOf("a", "b", "c");
      expect(list.elementAtOrElse(-1, (i) => "$i"), equals("-1"));
      expect(list.elementAtOrElse(10, (i) => "$i"), equals("10"));
    });

    test("null is not a valid index", () {
      final list = listOf("a", "b", "c");
      final e = catchException<ArgumentError>(
          () => list.elementAtOrElse(null, (i) => "x"));
      expect(e.message, allOf(contains("index"), contains("null")));
    });

    test("null is not a function", () {
      final list = listOf("a", "b", "c");
      final e =
          catchException<ArgumentError>(() => list.elementAtOrElse(1, null));
      expect(e.message, allOf(contains("defaultValue"), contains("null")));
    });
  });

  group("elementAtOrNull", () {
    test("returns correct elements", () {
      final list = listOf("a", "b", "c");
      expect(list.elementAtOrNull(0), equals("a"));
      expect(list.elementAtOrNull(1), equals("b"));
      expect(list.elementAtOrNull(2), equals("c"));
    });

    test("returns null when out of range", () {
      final list = listOf("a", "b", "c");
      expect(list.elementAtOrNull(-1), isNull);
      expect(list.elementAtOrNull(10), isNull);
    });

    test("null is not a valid index", () {
      final list = listOf("a", "b", "c");
      final e = catchException<ArgumentError>(() => list.elementAtOrNull(null));
      expect(e.message, allOf(contains("index"), contains("null")));
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
          throwsA(const TypeMatcher<NoSuchElementException>()));
      expect(() => listFrom().first(),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("finds nothing throws", () {
      expect(() => setOf<String>("a").first((it) => it == "b"),
          throwsA(const TypeMatcher<NoSuchElementException>()));
      expect(() => listOf("a").first((it) => it == "b"),
          throwsA(const TypeMatcher<NoSuchElementException>()));
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

  group("lastIndex", () {
    test("lastIndex for an empty list is -1", () {
      final list = emptyList();
      expect(list.lastIndex, -1);
    });

    test("lastIndex for 3 items is 2", () {
      final list = listOf("a", "b", "c");
      expect(list.lastIndex, 2);
    });
  });

  group("orEmpty", () {
    test("null -> empty list", () {
      const KtList<int> collection = null;
      expect(collection.orEmpty(), isNotNull);
      expect(collection.orEmpty(), isA<KtList<int>>());
      expect(collection.orEmpty().isEmpty(), isTrue);
      expect(collection.orEmpty().size, 0);
    });
    test("list -> just return the list", () {
      final KtList<int> collection = listOf(1, 2, 3);
      expect(collection.orEmpty(), collection);
      expect(identical(collection.orEmpty(), collection), isTrue);
    });
  });

  group("single", () {
    test("single", () {
      expect(listOf(1).single(), 1);
    });
    test("single throws when list has more elements", () {
      final e = catchException<ArgumentError>(() => listOf(1, 2).single());
      expect(e.message, contains("has more than one element"));
    });
    test("single throws for empty iterables", () {
      final e =
          catchException<NoSuchElementException>(() => emptyList().single());
      expect(e.message, contains("is empty"));
    });
    test("single with predicate finds item", () {
      final found = listOf("paul", "john", "max", "lisa")
          .single((it) => it.contains("x"));
      expect(found, "max");
    });
    test("single with predicate without match", () {
      final e = catchException<NoSuchElementException>(() =>
          listOf("paul", "john", "max", "lisa")
              .single((it) => it.contains("y")));
      expect(e.message, contains("no element matching the predicate"));
    });
    test("single with predicate multiple matches", () {
      final e = catchException<ArgumentError>(() =>
          listOf("paul", "john", "max", "lisa")
              .single((it) => it.contains("l")));
      expect(e.message, contains("more than one matching element"));
    });
  });

  group("singleOrNull", () {
    test("singleOrNull", () {
      expect(listOf(1).singleOrNull(), 1);
    });
    test("singleOrNull on multiple iterable returns null", () {
      expect(listOf(1, 2).singleOrNull(), null);
    });
    test("singleOrNull on empty iterable returns null", () {
      expect(emptyList().singleOrNull(), null);
    });
    test("singleOrNull with predicate finds item", () {
      final found = listOf("paul", "john", "max", "lisa")
          .singleOrNull((it) => it.contains("x"));
      expect(found, "max");
    });
    test("singleOrNull with predicate without match returns null", () {
      final result = listOf("paul", "john", "max", "lisa")
          .singleOrNull((it) => it.contains("y"));
      expect(result, null);
    });
    test("singleOrNull with predicate multiple matches returns null", () {
      final result = listOf("paul", "john", "max", "lisa")
          .singleOrNull((it) => it.contains("l"));
      expect(result, null);
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
      final result = list.slice(emptyList<int>());
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

  group("takeLast", () {
    test("takeLast zero returns empty", () {
      final list = listOf(1, 2, 3, 4);
      expect(list.takeLast(0).toList(), emptyList());
    });

    test("take negative throws", () {
      final list = listOf(1, 2, 3, 4);
      final e = catchException<ArgumentError>(() => list.takeLast(-3));
      expect(e.message, allOf(contains("-3"), contains("less than zero")));
    });

    test("take more than size returns full list", () {
      final list = listOf(1, 2, 3, 4);
      expect(list.takeLast(10).toList(), list.toList());
    });

    test("take smaller list size returns last elements", () {
      final list = listOf(1, 2, 3, 4);
      expect(list.takeLast(2).toList(), listOf(3, 4));
    });

    test("takeLast doesn't allow null as n", () {
      final list = emptyList<num>();
      final e = catchException<ArgumentError>(() => list.takeLast(null));
      expect(e.message, allOf(contains("null"), contains("n")));
    });

    test("take last element which is null", () {
      final list = listFrom([1, null]);
      expect(list.takeLast(1).toList(), listFrom<int>([null]));
      expect(list.takeLast(2).toList(), listFrom([1, null]));
    });
  });

  group("takeLastWhile", () {
    test("take no elements returns empty", () {
      final list = listOf(1, 2, 3, 4);
      expect(list.takeLastWhile((it) => false), emptyList());
    });

    test("take all elements returns original list", () {
      final list = listOf(1, 2, 3, 4);
      expect(list.takeLastWhile((it) => true), list.toList());
    });

    test("takeLastWhile larger 2", () {
      final list = listOf(1, 2, 3, 4);
      expect(list.takeLastWhile((it) => it > 2), listOf(3, 4));
    });

    test("takeLastWhile larger 1", () {
      final list = listOf(1, 2, 3, 4);
      expect(list.takeLastWhile((it) => it > 1), listOf(2, 3, 4));
    });

    test("takeLastWhile larger 3", () {
      final list = listOf(1, 2, 3, 4);
      expect(list.takeLastWhile((it) => it > 3), listOf(4));
    });

    test("predicate can't be null", () {
      final list = listOf("a", "b", "c");
      final e = catchException<ArgumentError>(() => list.takeLastWhile(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });
}
