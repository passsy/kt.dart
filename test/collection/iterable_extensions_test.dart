import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/iterable.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("KtIterableExtensions", () {
    group("iterable", () {
      // TODO replace with Iterable.generate once implemented
      testIterable(<T>() => EmptyIterable<T>(),
          <T>(Iterable<T> iterable) => DartIterable(iterable));
    });
    group("list", () {
      testIterable(<T>() => emptyList<T>(),
          <T>(Iterable<T> iterable) => listFrom(iterable));
    });
    group("KtList", () {
      testIterable(<T>() => KtList<T>.empty(),
          <T>(Iterable<T> iterable) => KtList<T>.from(iterable));
    });
    group("mutableList", () {
      testIterable(<T>() => emptyList<T>(),
          <T>(Iterable<T> iterable) => mutableListFrom(iterable));
    });
    group("KtMutableList", () {
      testIterable(<T>() => KtMutableList<T>.empty(),
          <T>(Iterable<T> iterable) => KtMutableList<T>.from(iterable));
    });
    group("set", () {
      testIterable(<T>() => emptySet<T>(),
          <T>(Iterable<T> iterable) => setFrom(iterable));
    });
    group("KtSet", () {
      testIterable(<T>() => KtSet<T>.empty(),
          <T>(Iterable<T> iterable) => KtSet<T>.from(iterable));
    });
    group("hashset", () {
      testIterable(<T>() => emptySet<T>(),
          <T>(Iterable<T> iterable) => hashSetFrom(iterable),
          ordered: false);
    });
    group("KHashSet", () {
      testIterable(<T>() => KtHashSet<T>.empty(),
          <T>(Iterable<T> iterable) => KtHashSet<T>.from(iterable),
          ordered: false);
    });
    group("linkedSet", () {
      testIterable(<T>() => linkedSetOf<T>(),
          <T>(Iterable<T> iterable) => linkedSetFrom(iterable));
    });
    group("KLinkedSet", () {
      testIterable(<T>() => KtLinkedSet<T>.empty(),
          <T>(Iterable<T> iterable) => KtLinkedSet<T>.from(iterable));
    });
  });
}

void testIterable(KtIterable<T> Function<T>() emptyIterable,
    KtIterable<T> Function<T>(Iterable<T> iterable) iterableOf,
    {bool ordered = true}) {
  group("all", () {
    test("matches all", () {
      final iterable = iterableOf(["abc", "bcd", "cde"]);
      expect(iterable.all((e) => e.contains("c")), isTrue);
    });
    test("matches none", () {
      final iterable = iterableOf(["abc", "bcd", "cde"]);
      expect(iterable.all((e) => e.contains("x")), isFalse);
    });
    test("matches one", () {
      final iterable = iterableOf(["abc", "bcd", "cde"]);
      expect(iterable.all((e) => e.contains("a")), isFalse);
    });
    test("predicate can't be null", () {
      final iterable = iterableOf(["abc", "bcd", "cde"]);
      final e = catchException<ArgumentError>(() => iterable.all(null));
      expect(e.message, allOf(contains("predicate"), contains("null")));
    });
  });

  group("any", () {
    test("matches single", () {
      final iterable = iterableOf(["abc", "bcd", "cde"]);
      expect(iterable.any((e) => e.contains("a")), isTrue);
    });
    test("matches all", () {
      final iterable = iterableOf(["abc", "bcd", "cde"]);
      expect(iterable.any((e) => e.contains("c")), isTrue);
    });
    test("is false when none matches", () {
      final iterable = iterableOf(["abc", "bcd", "cde"]);
      expect(iterable.any((e) => e.contains("x")), isFalse);
    });
    test("any without args returns true with items", () {
      final iterable = iterableOf(["abc", "bcd", "cde"]);
      expect(iterable.any(), isTrue);
    });
    test("any without args returns false for no items", () {
      final iterable = emptyIterable();
      expect(iterable.any(), isFalse);
    });
  });

  group("associate", () {
    test("associate", () {
      final list = iterableOf(["a", "b", "c"]);
      final result = list.associate((it) => KtPair(it.toUpperCase(), it));
      final expected = mapFrom({"A": "a", "B": "b", "C": "c"});
      expect(result, equals(expected));
    });
    test("associate on empty map", () {
      final list = emptyIterable<String>();
      final result = list.associate((it) => KtPair(it.toUpperCase(), it));
      expect(result, equals(emptyMap()));
    });
    test("associate doesn't allow null as transform function", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.associate(null));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });
  });

  group("associateBy", () {
    test("associateBy", () {
      final list = iterableOf(["a", "b", "c"]);
      final result = list.associateBy((it) => it.toUpperCase());
      final expected = mapFrom({"A": "a", "B": "b", "C": "c"});
      expect(result, equals(expected));
    });
    test("associateBy on empty map", () {
      final list = emptyList<String>();
      final result = list.associateWith((it) => it.toUpperCase());
      expect(result, equals(emptyMap()));
    });
    test("when conflicting keys, use last ", () {
      final list = iterableOf(["a", "b", "c"]);
      final result = list.associateBy((it) => it.length);
      expect(result.size, equals(1));
      expect(result.containsKey(1), isTrue);
    });

    test("associateBy doesn't allow null as keySelector", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.associateBy(null));
      expect(e.message, allOf(contains("null"), contains("keySelector")));
    });
  });

  group("associateByTo", () {
    test("associateByTo doesn't allow null destination", () {
      final list = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(
          () => list.associateByTo(null, (it) => it));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("associateByTransform", () {
    test("associateByTransform", () {
      final list = iterableOf(["a", "bb", "ccc"]);
      final result = list.associateByTransform(
          (it) => it.length, (it) => it.toUpperCase());
      final expected = mapFrom({1: "A", 2: "BB", 3: "CCC"});
      expect(result, equals(expected));
    });
    test("associateByTransform on empty map", () {
      final list = emptyList<String>();
      final result = list.associateWith((it) => it.toUpperCase());
      expect(result, equals(emptyMap()));
    });
    test("associateByTransform doesn't allow null as keySelector", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(
          () => list.associateByTransform(null, (it) => it));
      expect(e.message, allOf(contains("null"), contains("keySelector")));
    });
  });

  group("associateWith", () {
    test("associateWith", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final result = iterable.associateWith((it) => it.toUpperCase());
      final expected = mapFrom({"a": "A", "b": "B", "c": "C"});
      expect(result, equals(expected));
    });
    test("associateWith on empty map", () {
      final iterable = emptyIterable<String>();
      final result = iterable.associateWith((it) => it.toUpperCase());
      expect(result, equals(emptyMap()));
    });
    test("associateWith doesn't allow null as valueSelector", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.associateWith(null));
      expect(e.message, allOf(contains("null"), contains("valueSelector")));
    });
  });

  group("associateWithTo", () {
    test("associateWithTo same type", () {
      final iterable = iterableOf(["a", "bb", "ccc"]);
      final result = mutableMapFrom<String, int>();
      final filtered = iterable.associateWithTo(result, (it) => it.length);
      expect(identical(result, filtered), isTrue);
      expect(result, mapFrom({"a": 1, "bb": 2, "ccc": 3}));
    });
    test("associateWithTo super type", () {
      final iterable = iterableOf(["a", "bb", "ccc"]);
      final result = mutableMapFrom<String, num>();
      final filtered = iterable.associateWithTo(result, (it) => it.length);
      expect(identical(result, filtered), isTrue);
      expect(result, mapFrom({"a": 1, "bb": 2, "ccc": 3}));
    });
    test("associateWithTo wrong type throws", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final result = mutableMapFrom<String, String>();
      final e = catchException<ArgumentError>(
          () => iterable.associateWithTo(result, (entry) => entry.length));
      expect(
          e.message,
          allOf(
            contains("associateWithTo"),
            contains("destination"),
            contains("<String, String>"),
            contains("<String, int>"),
          ));
    });
    test("associateWithTo requires valueSelector to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      const String Function(String item) predicate = null;
      final other = mutableMapFrom<String, String>();
      final e = catchException<ArgumentError>(
          () => iterable.associateWithTo(other, predicate));
      expect(e.message, allOf(contains("null"), contains("valueSelector")));
    });
    test("associateWithTo requires destination to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(
          () => iterable.associateWithTo(null, (it) => it.toUpperCase()));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("average", () {
    test("average of ints", () {
      final ints = iterableOf([1, 2, 3, 4]);
      final result = ints.averageBy((it) => it);
      expect(result, equals(2.5));
    });
    test("average of empty is NaN", () {
      final ints = emptyIterable<num>();
      final result = ints.averageBy((it) => it);
      expect(identical(result, double.nan), isTrue);
    });
    test("average of nums", () {
      final ints = iterableOf([1, 2.0, 3, 4]);
      final result = ints.averageBy((it) => it);
      expect(result, equals(2.5));
    });
    test("averageBy doesn't allow null as selector", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.averageBy(null));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });
  });

  group("distinct", () {
    if (ordered) {
      test("distinct elements", () {
        final iterable = iterableOf(["a", "b", "c", "b"]);
        expect(iterable.distinct(), equals(listOf("a", "b", "c")));
      });
      test("distinct by ordered", () {
        final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
        expect(iterable.distinctBy((it) => it.length),
            equals(listOf("paul", "peter")));
      });
    } else {
      test("distinct elements", () {
        final iterable = iterableOf(["a", "b", "c", "b"]);
        expect(iterable.distinct().toSet(), equals(setOf("a", "b", "c")));
      });

      test("distinct by unordered", () {
        final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
        final distinct = iterable.distinctBy((it) => it.length);
        expect(distinct.contains("peter"), true);
        expect(
            distinct.contains("paul") ||
                distinct.contains("john") ||
                distinct.contains("lisa"),
            true);
      });
    }

    test("distinctBy doesn't allow null as selector", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.distinctBy(null));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });
  });

  group("count", () {
    test("count elements", () {
      expect(iterableOf([1, 2, 3, 4, 5]).count(), 5);
    });

    test("count even", () {
      expect(iterableOf([1, 2, 3, 4, 5]).count((it) => it % 2 == 0), 2);
    });
  });

  group("chunked", () {
    test("chunk", () {
      final chunks = iterableOf([1, 2, 3, 4, 5]).chunked(3);
      expect(chunks, listOf(listOf(1, 2, 3), listOf(4, 5)));
    });

    test("chunked doesn't allow null as size", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.chunked(null));
      expect(e.message, allOf(contains("null"), contains("size")));
    });

    test("chunkedTransform", () {
      final chunks =
          iterableOf([1, 2, 3, 4, 5]).chunkedTransform(3, (it) => it.sum());
      expect(chunks, listOf(6, 9));
    });

    test("chunkedTransform doesn't allow null as size", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(
          () => list.chunkedTransform(null, (it) => it));
      expect(e.message, allOf(contains("null"), contains("size")));
    });

    test("chunkedTransform doesn't allow null as transform function", () {
      final list = emptyIterable<String>();
      final e =
          catchException<ArgumentError>(() => list.chunkedTransform(3, null));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });
  });

  group("dart property", () {
    test("dart property returns a dart iterable", () {
      final Iterable<String> iterable = iterableOf(["a", "b", "c"]).dart;
      if (ordered) {
        expect(iterable.first, "a");
        expect(iterable.skip(1).first, "b");
        expect(iterable.skip(2).first, "c");
      }
      expect(iterable.length, 3);
    });
    test("dart property returns empty as original", () {
      final Iterable<String> iterable = emptyIterable<String>().dart;
      expect(iterable.length, 0);
    });
  });

  group("drop", () {
    if (ordered) {
      test("drop first value ordered", () {
        final iterable = iterableOf(["a", "b", "c"]);
        expect(iterable.drop(1), equals(listOf("b", "c")));
      });
    } else {
      test("drop on iterable returns a iterable", () {
        final iterable = emptyIterable<int>();
        expect(iterable.drop(1), const TypeMatcher<KtList<int>>());
      });
    }
    test("drop empty does nothing", () {
      final iterable = emptyIterable<int>();
      expect(iterable.drop(1).toList(), equals(emptyList<int>()));
    });
    test("drop on iterable returns a iterable", () {
      final iterable = emptyIterable<int>();
      expect(iterable.drop(1), const TypeMatcher<KtList<int>>());
    });

    test("drop negative, drops nothing", () {
      final iterable = iterableOf(["a", "b", "c"]);
      expect(iterable.drop(-10).toList(), iterable.toList());
    });

    test("drop doesn't allow null as size", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.drop(null));
      expect(e.message, allOf(contains("null"), contains("n")));
    });
  });

  group("dropWhile", () {
    if (ordered) {
      test("dropWhile two", () {
        final iterable = iterableOf(["a", "b", "c"]);
        expect(iterable.dropWhile((it) => it != "c"), equals(listOf("c")));
      });
      test("dropWhile one", () {
        final iterable = iterableOf(["a", "b", "c"]);
        expect(iterable.dropWhile((it) => it != "b"), equals(listOf("b", "c")));
      });
    } else {
      test("dropWhile first value unordered", () {
        final iterable = iterableOf(["a", "b", "c"]);
        int i = 0;
        expect(iterable.dropWhile((_) => ++i <= 2).size, 1);
      });
    }
    test("dropWhile empty does nothing", () {
      final iterable = emptyIterable<int>();
      expect(
          iterable.dropWhile((_) => false).toList(), equals(emptyList<int>()));
    });
    test("dropWhile all makes an empty list", () {
      final iterable = iterableOf(["a", "b", "c"]);
      expect(
          iterable.dropWhile((_) => true).toList(), equals(emptyList<int>()));
    });
    test("dropWhile on iterable returns a iterable", () {
      final iterable = emptyIterable<int>();
      expect(
          iterable.dropWhile((_) => false), const TypeMatcher<KtList<int>>());
    });
    test("dropWhile doesn't allow null as predicate", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.dropWhile(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("elementAt", () {
    if (ordered) {
      test("returns correct elements", () {
        final iterable = iterableOf(["a", "b", "c"]);
        expect(iterable.elementAt(0), equals("a"));
        expect(iterable.elementAt(1), equals("b"));
        expect(iterable.elementAt(2), equals("c"));
      });
    } else {
      test("returns all elements", () {
        final iterable = iterableOf(["a", "b", "c"]);
        final set = setOf(iterable.elementAt(0), iterable.elementAt(1),
            iterable.elementAt(2));
        expect(set.containsAll(iterable.toSet()), isTrue);
      });
    }

    test("throws out of bounds exceptions", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final eOver = catchException<IndexOutOfBoundsException>(
          () => iterable.elementAt(3));
      expect(eOver.message, allOf(contains("index"), contains("3")));

      final eUnder = catchException<IndexOutOfBoundsException>(
          () => iterable.elementAt(-1));
      expect(eUnder.message, allOf(contains("index"), contains("-1")));
    });

    test("null is not a valid index", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(() => iterable.elementAt(null));
      expect(e.message, allOf(contains("index"), contains("null")));
    });
  });

  group("elementAtOrElse", () {
    if (ordered) {
      test("returns correct elements", () {
        final iterable = iterableOf(["a", "b", "c"]);
        expect(iterable.elementAtOrElse(0, (i) => "x"), equals("a"));
        expect(iterable.elementAtOrElse(1, (i) => "x"), equals("b"));
        expect(iterable.elementAtOrElse(2, (i) => "x"), equals("c"));
      });
    } else {
      test("returns all elements", () {
        final iterable = iterableOf(["a", "b", "c"]);
        final set = setOf(
            iterable.elementAtOrElse(0, (i) => "x"),
            iterable.elementAtOrElse(1, (i) => "x"),
            iterable.elementAtOrElse(2, (i) => "x"));
        expect(set.containsAll(iterable.toSet()), isTrue);
      });
    }

    test("returns else case", () {
      final iterable = iterableOf(["a", "b", "c"]);
      expect(iterable.elementAtOrElse(-1, (i) => "x"), equals("x"));
    });

    test("returns else case based on index", () {
      final iterable = iterableOf(["a", "b", "c"]);
      expect(iterable.elementAtOrElse(-1, (i) => "$i"), equals("-1"));
      expect(iterable.elementAtOrElse(10, (i) => "$i"), equals("10"));
    });

    test("null is not a valid index", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(
          () => iterable.elementAtOrElse(null, (i) => "x"));
      expect(e.message, allOf(contains("index"), contains("null")));
    });

    test("null is not a function", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(
          () => iterable.elementAtOrElse(1, null));
      expect(e.message, allOf(contains("defaultValue"), contains("null")));
    });
  });

  group("elementAtOrNull", () {
    if (ordered) {
      test("returns correct elements", () {
        final iterable = iterableOf(["a", "b", "c"]);
        expect(iterable.elementAtOrNull(0), equals("a"));
        expect(iterable.elementAtOrNull(1), equals("b"));
        expect(iterable.elementAtOrNull(2), equals("c"));
      });
    } else {
      test("returns all elements", () {
        final iterable = iterableOf(["a", "b", "c"]);
        final set = setOf(iterable.elementAtOrNull(0),
            iterable.elementAtOrNull(1), iterable.elementAtOrNull(2));
        expect(set.containsAll(iterable.toSet()), isTrue);
      });
    }

    test("returns null when out of range", () {
      final iterable = iterableOf(["a", "b", "c"]);
      expect(iterable.elementAtOrNull(-1), isNull);
      expect(iterable.elementAtOrNull(10), isNull);
    });

    test("null is not a valid index", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e =
          catchException<ArgumentError>(() => iterable.elementAtOrNull(null));
      expect(e.message, allOf(contains("index"), contains("null")));
    });
  });

  group("filter", () {
    test("filter", () {
      final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
      expect(iterable.filter((it) => it.contains("a")).toSet(),
          equals(setOf("paul", "lisa")));
    });

    test("filter doesn't allow null as predicate", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.filter(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("filterTo", () {
    test("filterTo same type", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<int>();
      final filtered = iterable.filterTo(result, (it) => it < 10);
      expect(identical(result, filtered), isTrue);
      if (ordered) {
        expect(result, listOf(4, -12));
      } else {
        expect(result.toSet(), setOf(4, -12));
      }
    });
    test("filterTo super type", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<num>();
      final filtered = iterable.filterTo(result, (it) => it < 10);
      expect(identical(result, filtered), isTrue);
      if (ordered) {
        expect(result, listOf(4, -12));
      } else {
        expect(result.toSet(), equals(setOf(4, -12)));
      }
    });
    test("filterTo wrong type throws", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<String>();
      final e = catchException<ArgumentError>(
          () => iterable.filterTo(result, (it) => it < 10));
      expect(
          e.message,
          allOf(
            contains("filterTo"),
            contains("destination"),
            contains("<int>"),
            contains("<String>"),
          ));
    });
    test("filterTo requires predicate to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      const bool Function(String) predicate = null;
      final other = mutableListOf<String>();
      final e = catchException<ArgumentError>(
          () => iterable.filterTo(other, predicate));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
    test("filterTo requires destination to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(
          () => iterable.filterTo(null, (it) => true));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("filterIndexed", () {
    test("filterIndexed", () {
      final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
      var i = 0;
      expect(
          iterable.filterIndexed((index, it) {
            expect(index, i);
            i++;
            return it.contains("a");
          }).toSet(),
          equals(setOf("paul", "lisa")));
    });

    test("filterIndexed doesn't allow null as predicate", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.filterIndexed(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("filterIndexedTo", () {
    test("filterIndexedTo index is incrementing", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<int>();
      var index = 0;
      iterable.filterIndexedTo(result, (i, it) {
        expect(i, index);
        index++;
        return true;
      });
      expect(index, 4);
    });
    test("filterIndexedTo same type", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<int>();
      final filtered = iterable.filterIndexedTo(result, (i, it) => it < 10);
      expect(identical(result, filtered), isTrue);
      if (ordered) {
        expect(result, listOf(4, -12));
      } else {
        expect(result.toSet(), setOf(4, -12));
      }
    });
    test("filterIndexedTo super type", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<num>();
      final filtered = iterable.filterIndexedTo(result, (i, it) => it < 10);
      expect(identical(result, filtered), isTrue);
      if (ordered) {
        expect(result, listOf(4, -12));
      } else {
        expect(result.toSet(), equals(setOf(4, -12)));
      }
    });
    test("filterIndexedTo wrong type throws", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<String>();
      final e = catchException<ArgumentError>(
          () => iterable.filterIndexedTo(result, (i, it) => it < 10));
      expect(
          e.message,
          allOf(
            contains("filterIndexedTo"),
            contains("destination"),
            contains("<int>"),
            contains("<String>"),
          ));
    });
    test("filterIndexedTo requires predicate to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      const bool Function(int, String) predicate = null;
      final other = mutableListOf<String>();
      final e = catchException<ArgumentError>(
          () => iterable.filterIndexedTo(other, predicate));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
    test("filterIndexedTo requires destination to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(
          () => iterable.filterIndexedTo(null, (i, it) => true));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("filterNot", () {
    test("filterNot", () {
      final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
      expect(iterable.filterNot((it) => it.contains("a")).toSet(),
          equals(setOf("peter", "john")));
    });

    test("filterNot doesn't allow null as predicate", () {
      final list = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => list.filterNot(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("filterNotTo", () {
    test("filterNotTo same type", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<int>();
      final filtered = iterable.filterNotTo(result, (it) => it < 10);
      expect(identical(result, filtered), isTrue);
      if (ordered) {
        expect(result, listOf(25, 10));
      } else {
        expect(result.toSet(), setOf(25, 10));
      }
    });
    test("filterNotTo super type", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<num>();
      final filtered = iterable.filterNotTo(result, (it) => it < 10);
      expect(identical(result, filtered), isTrue);
      if (ordered) {
        expect(result, listOf(25, 10));
      } else {
        expect(result.toSet(), equals(setOf(25, 10)));
      }
    });
    test("filterNotTo wrong type throws", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<String>();
      final e = catchException<ArgumentError>(
          () => iterable.filterNotTo(result, (it) => it < 10));
      expect(
          e.message,
          allOf(
            contains("filterNotTo"),
            contains("destination"),
            contains("<int>"),
            contains("<String>"),
          ));
    });
    test("filterNotTo requires predicate to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      const bool Function(String) predicate = null;
      final other = mutableListOf<String>();
      final e = catchException<ArgumentError>(
          () => iterable.filterNotTo(other, predicate));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
    test("filterNotTo requires destination to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(
          () => iterable.filterNotTo(null, (it) => true));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("filterNotNull", () {
    test("filterNotNull", () {
      final iterable = iterableOf(["paul", null, "john", "lisa"]);
      expect(iterable.filterNotNull().toSet(),
          equals(setOf("paul", "john", "lisa")));
    });
  });

  group("filterNotNullTo", () {
    test("filterNotNullTo same type", () {
      final iterable = iterableOf([4, 25, null, 10]);
      final result = mutableListOf<int>();
      final filtered = iterable.filterNotNullTo(result);
      expect(identical(result, filtered), isTrue);
      if (ordered) {
        expect(result, listOf(4, 25, 10));
      } else {
        expect(result.toSet(), setOf(4, 25, 10));
      }
    });
    test("filterNotNullTo super type", () {
      final iterable = iterableOf([4, 25, null, 10]);
      final result = mutableListOf<num>();
      final filtered = iterable.filterNotNullTo(result);
      expect(identical(result, filtered), isTrue);
      if (ordered) {
        expect(result, listOf(4, 25, 10));
      } else {
        expect(result.toSet(), equals(setOf(4, 25, 10)));
      }
    });
    test("filterNotNullTo wrong type throws", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<String>();
      final e =
          catchException<ArgumentError>(() => iterable.filterNotNullTo(result));
      expect(
          e.message,
          allOf(
            contains("filterNotNullTo"),
            contains("destination"),
            contains("<int>"),
            contains("<String>"),
          ));
    });
    test("filterNotNullTo requires destination to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e =
          catchException<ArgumentError>(() => iterable.filterNotNullTo(null));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("filterIsInstance", () {
    test("filterIsInstance", () {
      final iterable = iterableOf<Object>(["paul", null, "john", 1, "lisa"]);
      expect(iterable.filterIsInstance<String>().toSet(),
          equals(setOf("paul", "john", "lisa")));
    });
  });

  group("find", () {
    test("find item", () {
      final iterable = iterableOf(["paul", "john", "max", "lisa"]);
      final result = iterable.find((it) => it.contains("l"));

      if (ordered) {
        expect(result, "paul");
      } else {
        expect(result, anyOf("paul", "lisa"));
      }
    });

    test("find predicate can't be null", () {
      final iterable = iterableOf([1, 2, 3]);
      final e = catchException<ArgumentError>(() => iterable.find(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("findLast", () {
    test("findLast item", () {
      final iterable = iterableOf(["paul", "john", "max", "lisa"]);
      final result = iterable.findLast((it) => it.contains("l"));
      if (ordered) {
        expect(result, "lisa");
      } else {
        expect(result, anyOf("paul", "lisa"));
      }
    });

    test("find predicate can't be null", () {
      final iterable = iterableOf([1, 2, 3]);
      final e = catchException<ArgumentError>(() => iterable.findLast(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("first", () {
    if (ordered) {
      test("get first element", () {
        expect(iterableOf(["a", "b"]).first(), "a");
      });
    } else {
      test("get random first element", () {
        final result = iterableOf(["a", "b"]).first();
        expect(result == "a" || result == "b", true);
      });
    }

    test("first throws for no elements", () {
      expect(() => emptyIterable().first(),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("finds nothing throws", () {
      expect(() => iterableOf<String>(["a"]).first((it) => it == "b"),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });
  });

  group("firstOrNull", () {
    if (ordered) {
      test("get first element", () {
        expect(iterableOf(["a", "b"]).firstOrNull(), "a");
      });
    } else {
      test("get random first element", () {
        final result = iterableOf(["a", "b"]).firstOrNull();
        expect(result == "a" || result == "b", true);
      });
    }

    test("firstOrNull returns null for empty", () {
      expect(emptyIterable().firstOrNull(), isNull);
    });

    test("finds nothing throws", () {
      expect(iterableOf<String>(["a"]).firstOrNull((it) => it == "b"), isNull);
    });
  });

  group("flatMap", () {
    test("flatMap int to string", () {
      final iterable = iterableOf([1, 2, 3]);
      expect(
          iterable.flatMap((it) => iterableOf([it, it + 1, it + 2])).toList(),
          listOf(1, 2, 3, 2, 3, 4, 3, 4, 5));
    });

    test("flatMap doesn't allow null as tranform function", () {
      final iterable = iterableOf([1, 2, 3]);
      final e = catchException<ArgumentError>(() => iterable.flatMap(null));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });

    test("flatMapTo doesn't allow null as destination", () {
      final iterable = iterableOf([1, 2, 3]);
      final e = catchException<ArgumentError>(
          () => iterable.flatMapTo(null, (_) => emptyIterable()));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("flatten", () {
    test("empty", () {
      final KtIterable<KtIterable<int>> nested =
          emptyIterable<KtIterable<int>>();
      expect(nested.flatten(), emptyList());
    });

    test("flatten KtIterable<KtIterable<T>>", () {
      final nested = iterableOf([
        iterableOf([1, 2, 3]),
        iterableOf([4, 5, 6]),
        iterableOf([7, 8, 9]),
      ]);
      if (ordered) {
        expect(nested.flatten(), listFrom([1, 2, 3, 4, 5, 6, 7, 8, 9]));
      } else {
        expect(nested.flatten().toSet(), setFrom([1, 2, 3, 4, 5, 6, 7, 8, 9]));
      }
    });
  });

  group("fold", () {
    if (ordered) {
      test("fold division", () {
        final iterable = iterableOf([
          [1, 2],
          [3, 4],
          [5, 6]
        ]);
        final result = iterable.fold(
            listFrom<int>(), (KtList<int> acc, it) => acc + listFrom(it));
        expect(result, listOf(1, 2, 3, 4, 5, 6));
      });
    }

    test("operation must be non null", () {
      final e = catchException<ArgumentError>(
          () => emptyIterable().fold("foo", null));
      expect(e.message, allOf(contains("null"), contains("operation")));
    });
  });

  group("foldIndexed", () {
    if (ordered) {
      test("foldIndexed division", () {
        final iterable = iterableOf([
          [1, 2],
          [3, 4],
          [5, 6]
        ]);
        var i = 0;
        final result =
            iterable.foldIndexed(listFrom<int>(), (index, KtList<int> acc, it) {
          expect(index, i);
          i++;
          return acc + listFrom(it);
        });
        expect(result, listOf(1, 2, 3, 4, 5, 6));
      });
    }

    test("operation must be non null", () {
      final e = catchException<ArgumentError>(
          () => emptyIterable().foldIndexed("foo", null));
      expect(e.message, allOf(contains("null"), contains("operation")));
    });
  });

  group("forEach", () {
    test("forEach", () {
      final result = mutableListOf<String>();
      final iterable = iterableOf(["a", "b", "c", "d"]);
      iterable.forEach((it) {
        result.add(it);
      });
      if (ordered) {
        expect(result, listOf("a", "b", "c", "d"));
      } else {
        expect(result.size, 4);
        expect(result.toSet(), iterable.toSet());
      }
    });

    test("action must be non null", () {
      final e =
          catchException<ArgumentError>(() => emptyIterable().forEach(null));
      expect(e.message, allOf(contains("null"), contains("action")));
    });
  });

  group("forEachIndexed", () {
    test("forEachIndexed", () {
      final result = mutableListOf<String>();
      final iterable = iterableOf(["a", "b", "c", "d"]);
      iterable.forEachIndexed((index, it) {
        result.add("$index$it");
      });
      if (ordered) {
        expect(result, listOf("0a", "1b", "2c", "3d"));
      } else {
        expect(result.size, 4);
        expect(result.toSet(),
            iterable.mapIndexed((index, it) => "$index$it").toSet());
      }
    });

    test("action must be non null", () {
      final e = catchException<ArgumentError>(
          () => emptyIterable().forEachIndexed(null));
      expect(e.message, allOf(contains("null"), contains("action")));
    });
  });

  group("groupBy", () {
    if (ordered) {
      test("basic", () {
        final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
        expect(
            iterable.groupBy((it) => it.length),
            equals(mapFrom({
              4: listOf("paul", "john", "lisa"),
              5: listOf("peter"),
            })));
      });

      test("valuetransform", () {
        final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
        expect(
            iterable.groupByTransform(
                (it) => it.length, (it) => it.toUpperCase()),
            equals(mapFrom({
              4: listOf("PAUL", "JOHN", "LISA"),
              5: listOf("PETER"),
            })));
      });
    } else {
      test("basic", () {
        final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
        expect(
            iterable
                .groupBy((it) => it.length)
                .mapValues((it) => it.value.toSet()),
            equals(mapFrom({
              4: setOf("paul", "john", "lisa"),
              5: setOf("peter"),
            })));
      });

      test("valuetransform", () {
        final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
        expect(
            iterable
                .groupByTransform((it) => it.length, (it) => it.toUpperCase())
                .mapValues((it) => it.value.toSet()),
            equals(mapFrom({
              4: setOf("PAUL", "JOHN", "LISA"),
              5: setOf("PETER"),
            })));
      });
    }

    test("groupBy doesn't allow null as keySelector", () {
      final iterable = iterableOf([1, 2, 3]);
      final e = catchException<ArgumentError>(() => iterable.groupBy(null));
      expect(e.message, allOf(contains("null"), contains("keySelector")));
    });
  });

  group("groupByTo", () {
    test("groupByTo same type", () {
      final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
      final result = mutableMapFrom<int, KtMutableList<String>>();
      final grouped = iterable.groupByTo(result, (it) => it.length);
      expect(identical(result, grouped), isTrue);
      expect(
          result,
          mapFrom({
            4: iterableOf(["paul", "john", "lisa"]).toList(),
            5: listOf("peter"),
          }));
    });
    test("groupByTo super type", () {
      final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
      final result = mutableMapFrom<int, KtMutableList<Pattern>>();
      final grouped = iterable.groupByTo(result, (it) => it.length);
      expect(identical(result, grouped), isTrue);
      expect(
          result,
          mapFrom({
            4: iterableOf(["paul", "john", "lisa"]).toList(),
            5: listOf("peter"),
          }));
    });
    test("groupByTo wrong type throws", () {
      final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
      final result = mutableMapFrom<int, KtMutableList<int>>();
      final e = catchException<ArgumentError>(
          () => iterable.groupByTo(result, (it) => it.length));
      expect(
          e.message,
          allOf(
            contains("groupByTo"),
            contains("destination"),
            contains("KtMutableList<int>"),
            contains("KtMutableList<String>"),
          ));
    });
    test("groupByTo requires destination to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(
          () => iterable.groupByTo(null, (it) => it.length));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
    test("groupByTo requires keySelector to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      const String Function(String) keySelector = null;
      final other = mutableMapFrom<String, KtMutableList<String>>();
      final e = catchException<ArgumentError>(
          () => iterable.groupByTo(other, keySelector));
      expect(e.message, allOf(contains("null"), contains("keySelector")));
    });
  });

  group("groupByTransform", () {
    test("groupByTransform doesn't allow null as keySelector", () {
      final iterable = iterableOf([1, 2, 3]);
      final e = catchException<ArgumentError>(
          () => iterable.groupByTransform(null, (it) => it));
      expect(e.message, allOf(contains("null"), contains("keySelector")));
    });

    test("groupByTransform doesn't allow null as valueTransform", () {
      final iterable = iterableOf([1, 2, 3]);
      final e = catchException<ArgumentError>(
          () => iterable.groupByTransform((it) => it, null));
      expect(e.message, allOf(contains("null"), contains("valueTransform")));
    });

    test("groupByToTransform doesn't allow null as destination", () {
      final iterable = iterableOf([1, 2, 3]);
      final e = catchException<ArgumentError>(
          () => iterable.groupByToTransform(null, (it) => it, (it) => it));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("groupByToTransform", () {
    test("groupByToTransform same type", () {
      final iterable = iterableOf(["paul", "peter", "john", "lisa"]);
      final result = mutableMapFrom<int, KtMutableList<String>>();
      final grouped = iterable.groupByToTransform(
          result, (it) => it.length, (it) => it.toUpperCase());
      expect(identical(result, grouped), isTrue);
      if (ordered) {
        expect(
            result,
            mapFrom({
              4: listOf("PAUL", "JOHN", "LISA"),
              5: listOf("PETER"),
            }));
      } else {
        expect(result.size, 2);
        expect(result[4].toSet(), setOf("PAUL", "JOHN", "LISA"));
        expect(result[5], listOf("PETER"));
      }
    });
    test("groupByToTransform requires destination to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(() => iterable.groupByToTransform(
          null, (it) => it.length, (it) => it.toUpperCase()));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
    test("groupByToTransform requires keySelector to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      const String Function(String) keySelector = null;
      final other = mutableMapFrom<String, KtMutableList<String>>();
      final e = catchException<ArgumentError>(() => iterable.groupByToTransform(
          other, keySelector, (it) => it.toUpperCase()));
      expect(e.message, allOf(contains("null"), contains("keySelector")));
    });
    test("groupByToTransform requires valueTransform to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      const String Function(String) valueSelector = null;
      final other = mutableMapFrom<String, KtMutableList<String>>();
      final e = catchException<ArgumentError>(() => iterable.groupByToTransform(
          other, (it) => it.toUpperCase(), valueSelector));
      expect(e.message, allOf(contains("null"), contains("valueTransform")));
    });
  });

  group("indexOf", () {
    test("returns index", () {
      final iterable = iterableOf(["a", "b", "c", "b"]);
      final found = iterable.indexOf("b");
      if (iterable.count() == 4) {
        // ordered list
        expect(found, 1);
      } else {
        // set, position is unknown
        expect(found, isNot(-1));
      }
    });
  });

  group("indexOfFirst", () {
    test("returns index", () {
      final iterable = iterableOf(["a", "b", "c", "b"]);
      final found = iterable.indexOfFirst((it) => it == "b");
      if (iterable.count() == 4) {
        // ordered list
        expect(found, 1);
      } else {
        // set, position is unknown
        expect(found, isNot(-1));
      }
    });

    test("not found returns -1", () {
      final iterable = iterableOf(["a", "b", "c", "b"]);
      final found = iterable.indexOfFirst((it) => it == "x");
      expect(found, -1);
    });

    test("indexOfFirst predicate can't be null", () {
      final iterable = iterableOf([1, 2, 3]);
      final e =
          catchException<ArgumentError>(() => iterable.indexOfFirst(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("indexOfLast", () {
    test("returns index", () {
      final iterable = iterableOf(["a", "b", "c", "b"]);
      final found = iterable.indexOfLast((it) => it == "b");
      if (iterable.count() == 4) {
        // ordered list
        expect(found, 3);
      } else {
        // set, position is unknown
        expect(found, isNot(-1));
      }
    });
    test("indexOfLast predicate can't be null", () {
      final iterable = iterableOf([1, 2, 3]);
      final e = catchException<ArgumentError>(() => iterable.indexOfLast(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("intersect", () {
    test("remove one item", () {
      final a = iterableOf(["paul", "john", "max", "lisa"]);
      final b = iterableOf(["julie", "richard", "john", "lisa"]);
      final result = a.intersect(b);
      expect(result, setOf("john", "lisa"));
    });

    test("other can't be null", () {
      final a = iterableOf(["paul", "john", "max", "lisa"]);
      final e = catchException<ArgumentError>(() => a.intersect(null));
      expect(e.message, allOf(contains("null")));
    });
  });

  group("joinToString", () {
    if (ordered) {
      test("joinToString", () {
        final s = iterableOf(["a", "b", "c"]).joinToString();
        expect(s, "a, b, c");
      });
      test("joinToString calls childs toString", () {
        final s = iterableOf([listOf(1, 2, 3), const KtPair("a", "b"), "test"])
            .joinToString();
        expect(s, "[1, 2, 3], (a, b), test");
      });
      test("with transform", () {
        final s = iterableOf(["a", "b", "c"])
            .joinToString(transform: (it) => it.toUpperCase());
        expect(s, "A, B, C");
      });
      test("custom separator", () {
        final s = iterableOf(["a", "b", "c"]).joinToString(separator: "/");
        expect(s, "a/b/c");
      });
      test("post and prefix", () {
        final s =
            iterableOf(["a", "b", "c"]).joinToString(prefix: "<", postfix: ">");
        expect(s, "<a, b, c>");
      });
      test("limit length", () {
        final s =
            iterableOf([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]).joinToString(limit: 7);
        expect(s, "1, 2, 3, 4, 5, 6, 7, ...");
      });
      test("custom truncated", () {
        final s = iterableOf([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
            .joinToString(limit: 7, truncated: "(and many more)");
        expect(s, "1, 2, 3, 4, 5, 6, 7, (and many more)");
      });
    }
  });

  group("last", () {
    if (ordered) {
      test("get last element", () {
        expect(iterableOf(["a", "b"]).last(), "b");
      });
    } else {
      test("get random last element", () {
        final result = iterableOf(["a", "b"]).last();
        expect(result == "a" || result == "b", true);
      });
    }

    test("last throws for no elements", () {
      expect(() => emptyIterable().last(),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("finds nothing throws", () {
      expect(() => iterableOf<String>(["a", "b", "c"]).last((it) => it == "x"),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("finds nothing in empty throws", () {
      expect(() => emptyIterable().last((it) => it == "x"),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("returns null when null is the last element", () {
      expect(listFrom([1, 2, null]).last(), null);
      expect(listFrom([1, null, 2]).last(), 2);
    });
  });

  group("lastOrNull", () {
    if (ordered) {
      test("get lastOrNull element", () {
        expect(iterableOf(["a", "b"]).lastOrNull(), "b");
      });
    } else {
      test("get random last element", () {
        final result = iterableOf(["a", "b"]).lastOrNull();
        expect(result == "a" || result == "b", true);
      });
    }

    test("lastOrNull returns null for empty", () {
      expect(emptyIterable().lastOrNull(), isNull);
    });

    test("finds nothing throws", () {
      expect(iterableOf<String>(["a"]).lastOrNull((it) => it == "b"), isNull);
    });
  });

  group("lastIndexOf", () {
    test("returns last index", () {
      final iterable = iterableOf(["a", "b", "c", "b"]);
      final found = iterable.lastIndexOf("b");
      if (iterable.count() == 4) {
        // ordered list
        expect(found, 3);
      } else {
        // set, position is unknown
        expect(found, isNot(-1));
      }
    });
  });

  group("map", () {
    test("map int to string", () {
      final iterable = iterableOf([1, 2, 3]);
      expect(
          iterable.map((it) => it.toString()).toList(), listOf("1", "2", "3"));
    });
  });

  group("map", () {
    test("map int to string", () {
      final iterable = iterableOf([1, 2, 3]);
      expect(
          iterable.map((it) => it.toString()).toList(), listOf("1", "2", "3"));
    });
  });

  group("mapNotNull", () {
    test("mapNotNull int to string", () {
      final iterable = iterableOf([1, null, 2, null, 3]);
      expect(iterable.mapNotNull((it) => it?.toString()).toList(),
          listOf("1", "2", "3"));
    });
  });

  group("mapNotNullTo", () {
    test("mapNotNullTo int to string", () {
      final list = mutableListOf<String>();
      final iterable = iterableOf([1, null, 2, null, 3]);
      iterable.mapNotNullTo(list, (it) => it?.toString());

      expect(list, listOf("1", "2", "3"));
    });

    test("mapNotNullTo doesn't allow null as destination", () {
      final iterable = iterableOf([1, 2, 3]);
      final e = catchException<ArgumentError>(
          () => iterable.mapNotNullTo(null, (it) => it));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });

    test("mapNotNullTo doesn't allow null as transform function", () {
      final iterable = iterableOf([1, 2, 3]);
      const int Function(int) mapper = null;
      final e = catchException<ArgumentError>(
          () => iterable.mapNotNullTo(mutableListOf<int>(), mapper));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });
  });

  group("mapTo", () {
    test("mapTo int to string", () {
      final list = mutableListOf<String>();
      final iterable = iterableOf([1, 2, 3]);
      iterable.mapTo(list, (it) => it.toString());

      expect(list, listOf("1", "2", "3"));
    });

    test("mapTo doesn't allow null as destination", () {
      final iterable = iterableOf([1, 2, 3]);
      final e =
          catchException<ArgumentError>(() => iterable.mapTo(null, (it) => it));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });

    test("mapTo doesn't allow null as transform function", () {
      final iterable = iterableOf([1, 2, 3]);
      const int Function(int) mapper = null;
      final e = catchException<ArgumentError>(
          () => iterable.mapTo(mutableListOf<int>(), mapper));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });
  });

  if (ordered) {
    group("mapIndexedTo", () {
      test("mapIndexedTo int to string", () {
        final list = mutableListOf<String>();
        final iterable = iterableOf(["a", "b", "c"]);
        iterable.mapIndexedTo(list, (index, it) => "$index$it");

        expect(list, listOf("0a", "1b", "2c"));
      });

      test("mapIndexedTo doesn't allow null as destination", () {
        final iterable = iterableOf([1, 2, 3]);
        final e = catchException<ArgumentError>(
            () => iterable.mapIndexedTo(null, (_, it) => it));
        expect(e.message, allOf(contains("null"), contains("destination")));
      });

      test("mapIndexedTo doesn't allow null as transform function", () {
        final iterable = iterableOf([1, 2, 3]);
        const int Function(int, int) indexedMapper = null;
        final e = catchException<ArgumentError>(
            () => iterable.mapIndexedTo(mutableListOf<int>(), indexedMapper));
        expect(e.message, allOf(contains("null"), contains("transform")));
      });
    });
  }

  if (ordered) {
    group("mapIndexed", () {
      test("mapIndexed int to string", () {
        final iterable = iterableOf(["a", "b", "c"]);
        final result = iterable.mapIndexed((index, it) => "$index$it");

        expect(result, listOf("0a", "1b", "2c"));
      });
    });
  }

  if (ordered) {
    group("mapIndexedNotNull", () {
      test("mapIndexedNotNull int to string", () {
        final iterable = iterableOf(["a", null, "b", "c"]);
        expect(
            iterable.mapIndexedNotNull((index, it) {
              if (it == null) return null;
              return "$index$it";
            }).toList(),
            listOf("0a", "2b", "3c"));
      });
    });
  }

  if (ordered) {
    group("mapIndexedNotNull", () {
      test("mapIndexedNotNull int to string", () {
        final set = linkedSetOf<String>();
        final iterable = iterableOf(["a", null, "b", "c"]);
        iterable.mapIndexedNotNullTo(set, (index, it) {
          if (it == null) return null;
          return "$index$it";
        }).toList();
        expect(set, setOf("0a", "2b", "3c"));
      });

      test("mapIndexedNotNullTo doesn't allow null as destination", () {
        final iterable = iterableOf([1, 2, 3]);
        final e = catchException<ArgumentError>(
            () => iterable.mapIndexedNotNullTo(null, (_, it) => it));
        expect(e.message, allOf(contains("null"), contains("destination")));
      });

      test("mapIndexedNotNullTo doesn't allow null as transform function", () {
        final iterable = iterableOf([1, 2, 3]);
        const int Function(int, int) indexedMapper = null;
        final e = catchException<ArgumentError>(() =>
            iterable.mapIndexedNotNullTo(mutableListOf<int>(), indexedMapper));
        expect(e.message, allOf(contains("null"), contains("transform")));
      });
    });
  }

  group("max", () {
    test("gets max value int", () {
      final iterable = iterableOf([1, 3, 2]);
      final int max = iterable.max();
      expect(max, 3);
    });

    test("gets max value double", () {
      final iterable = iterableOf([1.0, 3.2, 2.0]);
      final double max = iterable.max();
      expect(max, 3.2);
    });

    test("gets max value comparable", () {
      final iterable = iterableOf(["a", "x", "b"]);
      final String max = iterable.max();
      expect(max, "x");
    });

    test("empty iterable return null", () {
      final iterable = emptyIterable<int>();
      final int max = iterable.max();
      expect(max, null);
    });
  });

  group("maxBy", () {
    test("gets max value", () {
      final iterable = iterableOf(["1", "3", "2"]);
      expect(iterable.maxBy((it) => num.parse(it)), "3");
    });

    test("empty iterable return null", () {
      final iterable = emptyIterable<int>();
      expect(iterable.maxBy<num>((it) => it), null);
    });

    test("maxBy requires a non null selector", () {
      final e =
          catchException<ArgumentError>(() => emptyIterable().maxBy<num>(null));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });
  });

  group("maxWith", () {
    int _intComparison(int value, int other) => value.compareTo(other);
    int _doubleComparison(double value, double other) => value.compareTo(other);

    test("gets max value int", () {
      final iterable = iterableOf([2, 1, 3]);
      expect(iterable.maxWith(_intComparison), 3);
    });

    test("gets max value double", () {
      final iterable = iterableOf([2.0, 1.0, 3.2]);
      expect(iterable.maxWith(_doubleComparison), 3.2);
    });

    test("empty iterable return null", () {
      final iterable = emptyIterable<int>();
      expect(iterable.maxWith(_intComparison), null);
    });

    test("maxWith requires a non null comparator", () {
      final e =
          catchException<ArgumentError>(() => emptyIterable().maxWith(null));
      expect(e.message, allOf(contains("null"), contains("comparator")));
    });
  });

  group("min", () {
    test("gets min int value", () {
      final KtIterable<int> iterable = iterableOf([3, 1, 2]);
      final int min = iterable.min();
      expect(min, 1);
    });

    test("gets min double value", () {
      final KtIterable<double> iterable = iterableOf([3.2, 1.4, 2.2]);
      final double min = iterable.min();
      expect(min, 1.4);
    });

    test("gets max value comparable", () {
      final iterable = iterableOf(["x", "b", "a", "h"]);
      final String min = iterable.min();
      expect(min, "a");
    });

    test("empty iterable return null", () {
      final iterable = emptyIterable<int>();
      final int min = iterable.min();
      expect(min, null);
    });
  });

  group("minBy", () {
    test("gets min value", () {
      final iterable = iterableOf(["1", "3", "2"]);
      expect(iterable.minBy((it) => num.parse(it)), "1");
    });

    test("empty iterable return null", () {
      final iterable = emptyIterable<int>();
      expect(iterable.minBy<num>((it) => it), null);
    });

    test("minBy requires a non null selector", () {
      final e =
          catchException<ArgumentError>(() => emptyIterable().minBy<num>(null));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });
  });

  group("minWith", () {
    int _intComparison(int value, int other) => value.compareTo(other);

    test("gets min value", () {
      final iterable = iterableOf([2, 1, 3]);
      expect(iterable.minWith(_intComparison), 1);
    });

    test("empty iterable return null", () {
      final iterable = emptyIterable<int>();
      expect(iterable.minWith(_intComparison), null);
    });

    test("minWith requires a non null comparator", () {
      final e =
          catchException<ArgumentError>(() => emptyIterable().minWith(null));
      expect(e.message, allOf(contains("null"), contains("comparator")));
    });
  });

  group("minus", () {
    if (ordered) {
      test("remove iterable", () {
        final result = iterableOf(["paul", "john", "max", "lisa"])
            .minus(iterableOf(["max", "john"]));
        expect(result, listOf("paul", "lisa"));
      });

      test("infix", () {
        final result =
            iterableOf(["paul", "john", "max", "lisa"]) - iterableOf(["max"]);
        expect(result.toList(), listOf("paul", "john", "lisa"));
      });

      test("remove one item", () {
        final result =
            iterableOf(["paul", "john", "max", "lisa"]).minusElement("max");
        expect(result.toList(), listOf("paul", "john", "lisa"));
      });
    } else {
      test("remove iterable", () {
        final result = iterableOf(["paul", "john", "max", "lisa"])
            .minus(iterableOf(["max", "john"]));
        expect(result.toSet(), setOf("paul", "lisa"));
      });

      test("infix", () {
        final result =
            iterableOf(["paul", "john", "max", "lisa"]) - iterableOf(["max"]);
        expect(result.toSet(), setOf("paul", "john", "lisa"));
      });

      test("remove one item", () {
        final result =
            iterableOf(["paul", "john", "max", "lisa"]).minusElement("max");
        expect(result.toSet(), setOf("paul", "john", "lisa"));
      });
    }

    test("empty gets returned empty", () {
      final result = emptyIterable() - iterableOf(["max"]);
      expect(result.toList(), emptyList());
    });

    test("minus doesn't allow null as elements", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => iterable.minus(null));
      expect(e.message, allOf(contains("null"), contains("elements")));
    });
  });

  group("none", () {
    test("no matching returns true", () {
      final items = iterableOf(["paul", "john", "max", "lisa"]);
      expect(items.none((it) => it.contains("y")), isTrue);
    });
    test("matching returns false", () {
      final items = iterableOf(["paul", "john", "max", "lisa"]);
      expect(items.none((it) => it.contains("p")), isFalse);
    });

    test("none without predicate returns false when iterable has items", () {
      final items = iterableOf(["paul", "john", "max", "lisa"]);
      expect(items.none(), isFalse);
    });

    test("empty returns always true", () {
      expect(emptyIterable().none(), isTrue);
    });
  });

  group("onEach", () {
    test("onEach", () {
      final iterable = iterableOf([
        [1, 2],
        [3, 4],
        [5, 6]
      ]);
      iterable.onEach((it) => it.add(0));
      expect(iterable.map((it) => it.last).toList(), listOf(0, 0, 0));
    });

    test("onEach doesn't allow null as action", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => iterable.onEach(null));
      expect(e.message, allOf(contains("null"), contains("action")));
    });
  });

  group("partition", () {
    test("partition", () {
      final result =
          iterableOf([7, 31, 4, 3, 92, 32]).partition((it) => it > 10);
      expect(result.first.toSet(), setOf(31, 92, 32));
      expect(result.second.toSet(), setOf(7, 4, 3));
    });

    test("partition doesn't allow null as predicate", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => iterable.partition(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("plus", () {
    test("concat two iterables", () {
      final result = iterableOf([1, 2, 3]).plus(iterableOf([4, 5, 6]));
      expect(result.toList(), listOf(1, 2, 3, 4, 5, 6));
    });

    test("infix", () {
      final result = iterableOf([1, 2, 3]) + iterableOf([4, 5, 6]);
      expect(result.toList(), listOf(1, 2, 3, 4, 5, 6));
    });

    test("plus doesn't allow null as elements", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => iterable.plus(null));
      expect(e.message, allOf(contains("null"), contains("elements")));
    });
  });

  group("plusElement", () {
    test("concat item", () {
      final result = iterableOf([1, 2, 3]).plusElement(5);
      expect(result.toList(), listOf(1, 2, 3, 5));
    });

    test("element can be null", () {
      final result = iterableOf([1, 2, 3]).plusElement(null);
      expect(result.toList(), listFrom([1, 2, 3, null]));
    });
  });

  group("reduce", () {
    test("reduce", () {
      final result = iterableOf([1, 2, 3, 4]).reduce((int acc, it) => it + acc);
      expect(result, 10);
    });

    test("empty throws", () {
      expect(() => emptyIterable<int>().reduce((int acc, it) => it + acc),
          throwsUnsupportedError);
    });

    test("reduce doesn't allow null as operation", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => iterable.reduce(null));
      expect(e.message, allOf(contains("null"), contains("operation")));
    });
  });

  group("reduceIndexed", () {
    test("reduceIndexed", () {
      var i = 1;
      final result =
          iterableOf([1, 2, 3, 4]).reduceIndexed((index, int acc, it) {
        expect(index, i);
        i++;
        return it + acc;
      });
      expect(result, 10);
    });

    test("empty throws", () {
      expect(
          () => emptyIterable<int>()
              .reduceIndexed((index, int acc, it) => it + acc),
          throwsUnsupportedError);
    });

    test("reduceIndexed doesn't allow null as operation", () {
      final iterable = emptyIterable<String>();
      final e =
          catchException<ArgumentError>(() => iterable.reduceIndexed(null));
      expect(e.message, allOf(contains("null"), contains("operation")));
    });
  });

  group("requireNoNulls", () {
    test("throw when nulls are found", () {
      final e = catchException<ArgumentError>(
          () => iterableOf(["paul", null, "john", "lisa"]).requireNoNulls());
      expect(e.message, contains("null element found"));
    });
  });

  group("reversed", () {
    test("mutliple", () {
      final result = iterableOf([1, 2, 3, 4]).reversed();
      expect(result.toList(), listOf(4, 3, 2, 1));
    });

    test("empty", () {
      expect(emptyIterable<int>().reversed().toList(), emptyList<int>());
    });

    test("one", () {
      expect(iterableOf<int>([1]).reversed().toList(), listFrom<int>([1]));
    });
  });

  group("single", () {
    test("single", () {
      expect(iterableOf([1]).single(), 1);
    });
    test("single throws when list has more elements", () {
      final e =
          catchException<ArgumentError>(() => iterableOf([1, 2]).single());
      expect(e.message, contains("has more than one element"));
    });
    test("single throws for empty iterables", () {
      final e = catchException<NoSuchElementException>(
          () => emptyIterable().single());
      expect(e.message, contains("is empty"));
    });
    test("single with predicate finds item", () {
      final found = iterableOf(["paul", "john", "max", "lisa"])
          .single((it) => it.contains("x"));
      expect(found, "max");
    });
    test("single with predicate without match", () {
      final e = catchException<NoSuchElementException>(() =>
          iterableOf(["paul", "john", "max", "lisa"])
              .single((it) => it.contains("y")));
      expect(e.message, contains("no element matching the predicate"));
    });
    test("single with predicate multiple matches", () {
      final e = catchException<ArgumentError>(() =>
          iterableOf(["paul", "john", "max", "lisa"])
              .single((it) => it.contains("l")));
      expect(e.message, contains("more than one matching element"));
    });
  });

  group("singleOrNull", () {
    test("singleOrNull", () {
      expect(iterableOf([1]).singleOrNull(), 1);
    });
    test("singleOrNull on multiple iterable returns null", () {
      expect(iterableOf([1, 2]).singleOrNull(), null);
    });
    test("singleOrNull on empty iterable returns null", () {
      expect(emptyIterable().singleOrNull(), null);
    });
    test("singleOrNull with predicate finds item", () {
      final found = iterableOf(["paul", "john", "max", "lisa"])
          .singleOrNull((it) => it.contains("x"));
      expect(found, "max");
    });
    test("singleOrNull with predicate without match returns null", () {
      final result = iterableOf(["paul", "john", "max", "lisa"])
          .singleOrNull((it) => it.contains("y"));
      expect(result, null);
    });
    test("singleOrNull with predicate multiple matches returns null", () {
      final result = iterableOf(["paul", "john", "max", "lisa"])
          .singleOrNull((it) => it.contains("l"));
      expect(result, null);
    });
  });

  group("sort", () {
    test("sort", () {
      final result = iterableOf([4, 2, 3, 1]).sorted();
      expect(result.toList(), listOf(1, 2, 3, 4));
    });

    test("sortedDescending", () {
      final result = iterableOf([4, 2, 3, 1]).sortedDescending();
      expect(result.toList(), listOf(4, 3, 2, 1));
    });

    String lastChar(String it) {
      final last = it.runes.last;
      return String.fromCharCode(last);
    }

    test("sortedBy", () {
      final result =
          iterableOf(["paul", "john", "max", "lisa"]).sortedBy(lastChar);
      expect(result, listOf("lisa", "paul", "john", "max"));
    });

    test("sortedBy for ints", () {
      final result = iterableOf(["paul", "john", "max", "lisa"])
          .sortedBy((it) => it.length);
      if (ordered) {
        expect(result, listOf("max", "paul", "john", "lisa"));
      } else {
        expect(result.first(), "max");
      }
    });

    test("sortedBy with doubles", () {
      final result = iterableOf(["paul", "john", "max", "lisa"])
          .sortedBy((it) => it.length / it.indexOf("a"));
      expect(result, listOf("john", "lisa", "max", "paul"));
    });

    test("sortedByDescending", () {
      final result = iterableOf(["paul", "john", "max", "lisa"])
          .sortedByDescending(lastChar);
      expect(result, listOf("max", "john", "paul", "lisa"));
    });

    test("sortedBy doesn't allow null as selector", () {
      final iterable = emptyIterable<String>();
      const num Function(String) sortFun = null;
      final e = catchException<ArgumentError>(() => iterable.sortedBy(sortFun));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });

    test("sortedByDescending doesn't allow null as selector", () {
      final iterable = emptyIterable<String>();
      const num Function(String) sortFun = null;
      final e = catchException<ArgumentError>(
          () => iterable.sortedByDescending(sortFun));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });
    test("sortedWith doesn't allow null as comparator", () {
      final iterable = emptyIterable<String>();
      const Comparator comparator = null;
      final e =
          catchException<ArgumentError>(() => iterable.sortedWith(comparator));
      expect(e.message, allOf(contains("null"), contains("comparator")));
    });
  });

  group("subtract", () {
    test("remove one item", () {
      final result = iterableOf(["paul", "john", "max", "lisa"])
          .subtract(iterableOf(["max"]));
      expect(result, setOf("paul", "john", "lisa"));
    });

    test("subtract doesn't allow null as other", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => iterable.subtract(null));
      expect(e.message, allOf(contains("null"), contains("other")));
    });
  });

  group("sum", () {
    test("sum of ints", () {
      expect(iterableOf([1, 2, 3, 4, 5]).sum(), 15);
    });

    test("sum of doubles", () {
      final sum = iterableOf([1.0, 2.1, 3.2]).sum();
      expect(sum, closeTo(6.3, 0.000000001));
    });
  });

  group("sumBy", () {
    test("double", () {
      expect(iterableOf([1, 2, 3]).sumBy((i) => i * 2), 12);
    });

    test("factor 1.5", () {
      expect(iterableOf([1, 2, 3]).sumByDouble((i) => i * 1.5), 9.0);
    });

    test("sumBy doesn't allow null as selector", () {
      final iterable = emptyIterable<num>();
      final e = catchException<ArgumentError>(() => iterable.sumBy(null));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });

    test("sumByDouble doesn't allow null as selector", () {
      final iterable = emptyIterable<num>();
      final e = catchException<ArgumentError>(() => iterable.sumByDouble(null));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });
  });

  group("take", () {
    test("take zero returns empty", () {
      final iterable = iterableOf([1, 2, 3, 4]);
      expect(iterable.take(0).toList(), emptyList());
    });

    test("take negative throws", () {
      final iterable = iterableOf([1, 2, 3, 4]);
      final e = catchException<ArgumentError>(() => iterable.take(-3));
      expect(e.message, allOf(contains("-3"), contains("less than zero")));
    });

    test("take more than size returns full list", () {
      final iterable = iterableOf([1, 2, 3, 4]);
      expect(iterable.take(10).toList(), iterable.toList());
    });

    if (ordered) {
      test("take smaller list size returns first elements", () {
        final iterable = iterableOf([1, 2, 3, 4]);
        expect(iterable.take(2).toList(), listOf(1, 2));
      });
    }

    test("take doesn't allow null as n", () {
      final iterable = emptyIterable<num>();
      final e = catchException<ArgumentError>(() => iterable.take(null));
      expect(e.message, allOf(contains("null"), contains("n")));
    });

    if (ordered) {
      test("take first element which is null", () {
        final iterable = iterableOf([null, 1]);
        expect(iterable.take(1).toList(), listFrom([null]));
        expect(iterable.take(2).toList(), listFrom([null, 1]));
      });
    }
  });

  group("takeWhile", () {
    test("take no elements returns empty", () {
      final iterable = iterableOf([1, 2, 3, 4]);
      expect(iterable.takeWhile((it) => false), emptyList());
    });

    test("take all elements returns original list", () {
      final iterable = iterableOf([1, 2, 3, 4]);
      expect(iterable.takeWhile((it) => true), iterable.toList());
    });

    if (ordered) {
      test("takeWhile smaller 3", () {
        final iterable = iterableOf([1, 2, 3, 4]);
        expect(iterable.takeWhile((it) => it < 3), listOf(1, 2));
      });
    }

    test("predicate can't be null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e = catchException<ArgumentError>(() => iterable.takeWhile(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("toHashSet", () {
    test("toHashSet", () {
      final list = iterableOf(["a", "b", "c", "b"]);
      expect(list.toHashSet().size, 3);
    });
  });

  group("toCollection", () {
    test("toCollection same type", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<int>();
      final filtered = iterable.toCollection(result);
      expect(identical(result, filtered), isTrue);
      if (ordered) {
        expect(result, listOf(4, 25, -12, 10));
      } else {
        expect(result.toSet(), setOf(4, 25, -12, 10));
      }
    });
    test("toCollection super type", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<num>();
      final filtered = iterable.toCollection(result);
      expect(identical(result, filtered), isTrue);
      if (ordered) {
        expect(result, listOf(4, 25, -12, 10));
      } else {
        expect(result.toSet(), equals(setOf(4, 25, -12, 10)));
      }
    });
    test("toCollection wrong type throws", () {
      final iterable = iterableOf([4, 25, -12, 10]);
      final result = mutableListOf<String>();
      final e =
          catchException<ArgumentError>(() => iterable.toCollection(result));
      expect(
          e.message,
          allOf(
            contains("toCollection"),
            contains("destination"),
            contains("<int>"),
            contains("<String>"),
          ));
    });
    test("toCollection requires destination to be non null", () {
      final iterable = iterableOf(["a", "b", "c"]);
      final e =
          catchException<ArgumentError>(() => iterable.toCollection(null));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("union", () {
    test("concat two iterables", () {
      final result = iterableOf([1, 2, 3]).union(iterableOf([4, 5, 6]));
      expect(result.toList(), listOf(1, 2, 3, 4, 5, 6));
    });

    test("union doesn't allow null as other", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => iterable.union(null));
      expect(e.message, allOf(contains("null"), contains("other")));
    });
  });

  group("windowed", () {
    test("default step", () {
      expect(
          iterableOf([1, 2, 3, 4, 5]).windowed(3),
          listOf(
            listOf(1, 2, 3),
            listOf(2, 3, 4),
            listOf(3, 4, 5),
          ));
    });

    test("larger step", () {
      expect(
          iterableOf([1, 2, 3, 4, 5]).windowed(3, step: 2),
          listOf(
            listOf(1, 2, 3),
            listOf(3, 4, 5),
          ));
    });

    test("step doesn't fit length", () {
      expect(
          iterableOf([1, 2, 3, 4, 5, 6]).windowed(3, step: 2),
          listOf(
            listOf(1, 2, 3),
            listOf(3, 4, 5),
          ));
    });

    test("window can be smaller than length", () {
      expect(iterableOf([1]).windowed(3, step: 2), emptyList());
    });

    test("step doesn't fit length, partial", () {
      expect(
          iterableOf([1, 2, 3, 4, 5, 6])
              .windowed(3, step: 2, partialWindows: true),
          listOf(
            listOf(1, 2, 3),
            listOf(3, 4, 5),
            listOf(5, 6),
          ));
    });
    test("partial doesn't crash on empty iterable", () {
      expect(emptyIterable().windowed(3, step: 2, partialWindows: true),
          emptyList());
    });
    test("window can be smaller than length, emitting partial only", () {
      expect(iterableOf([1]).windowed(3, step: 2, partialWindows: true),
          listOf(listOf(1)));
    });

    test("window doesn't allow null as size", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => iterable.windowed(null));
      expect(e.message, allOf(contains("null"), contains("size")));
    });

    test("window doesn't allow null as step", () {
      final iterable = emptyIterable<String>();
      final e =
          catchException<ArgumentError>(() => iterable.windowed(3, step: null));
      expect(e.message, allOf(contains("null"), contains("step")));
    });

    test("window doesn't allow null as partialWindows", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(
          () => iterable.windowed(3, partialWindows: null));
      expect(e.message, allOf(contains("null"), contains("partialWindows")));
    });
  });

  group("unzip", () {
    test("empty", () {
      final KtIterable<KtPair<String, int>> zipped =
          emptyIterable<KtPair<String, int>>();
      final unzipped = zipped.unzip();
      expect(unzipped.first, emptyList());
      expect(unzipped.second, emptyList());
    });

    test("unzip pairs", () {
      final zipped = iterableOf([
        const KtPair("a", 1),
        const KtPair("b", 2),
        const KtPair("c", 3),
      ]);
      final unzipped = zipped.unzip();
      if (ordered) {
        expect(unzipped.first, listOf("a", "b", "c"));
        expect(unzipped.second, listOf(1, 2, 3));
      } else {
        expect(unzipped.first.toSet(), setOf("a", "b", "c"));
        expect(unzipped.second.toSet(), setOf(1, 2, 3));
      }
    });
  });

  group("windowedTransform", () {
    test("default step", () {
      expect(iterableOf([1, 2, 3, 4, 5]).windowedTransform(3, (l) => l.sum()),
          listOf(6, 9, 12));
    });

    test("larger step", () {
      expect(
          iterableOf([1, 2, 3, 4, 5])
              .windowedTransform(3, (l) => l.sum(), step: 2),
          listOf(6, 12));
    });

    test("step doesn't fit length", () {
      expect(
          iterableOf([1, 2, 3, 4, 5, 6])
              .windowedTransform(3, (l) => l.sum(), step: 2),
          listOf(6, 12));
    });

    test("window can be smaller than length", () {
      expect(iterableOf([1]).windowed(3, step: 2), emptyList());
    });

    test("step doesn't fit length, partial", () {
      expect(
          iterableOf([1, 2, 3, 4, 5, 6]).windowedTransform(3, (l) => l.sum(),
              step: 2, partialWindows: true),
          listOf(6, 12, 11));
    });
    test("partial doesn't crash on empty iterable", () {
      expect(
          emptyIterable().windowedTransform(
              3, (l) => throw StateError("this gets never executed"),
              step: 2, partialWindows: true),
          emptyList());
    });
    test("window can be smaller than length, emitting partial only", () {
      expect(
          iterableOf([1]).windowedTransform(3, (l) => l.sum(),
              step: 2, partialWindows: true),
          listOf(1));
    });

    test("windowedTransform doesn't allow null as size", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(
          () => iterable.windowedTransform(null, (it) => it));
      expect(e.message, allOf(contains("null"), contains("size")));
    });

    test("windowedTransform doesn't allow null as transform function", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(
          () => iterable.windowedTransform(3, null));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });

    test("windowedTransform doesn't allow null as step", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(
          () => iterable.windowedTransform(3, (it) => it, step: null));
      expect(e.message, allOf(contains("null"), contains("step")));
    });

    test("windowedTransform doesn't allow null as partialWindows", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(() =>
          iterable.windowedTransform(3, (it) => it, partialWindows: null));
      expect(e.message, allOf(contains("null"), contains("partialWindows")));
    });
  });

  group("zip", () {
    test("to pair", () {
      final result = iterableOf([1, 2, 3, 4, 5]).zip(iterableOf(["a", "b"]));
      expect(result, listFrom(const [KtPair(1, "a"), KtPair(2, "b")]));
    });
    test("transform", () {
      final result = iterableOf([1, 2, 3, 4, 5])
          .zipTransform(iterableOf(["a", "b"]), (a, b) => "$a$b");
      expect(result, listOf("1a", "2b"));
    });

    test("zip doesn't allow null as other", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(() => iterable.zip(null));
      expect(e.message, allOf(contains("null"), contains("other")));
    });
    test("zipTransform doesn't allow null as other", () {
      final iterable = emptyIterable<String>();
      final e = catchException<ArgumentError>(
          () => iterable.zipTransform(null, (a, b) => a));
      expect(e.message, allOf(contains("null"), contains("other")));
    });
    test("zipTransform doesn't allow null as transform function", () {
      final iterable = emptyIterable<String>();
      const int Function(dynamic, dynamic) transform = null;
      final e = catchException<ArgumentError>(
          () => iterable.zipTransform(emptyIterable(), transform));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });
  });

  group("zipWithNext", () {
    test("zipWithNext", () {
      final result = iterableOf([1, 2, 3]).zipWithNext();
      expect(result, listOf(const KtPair(1, 2), const KtPair(2, 3)));
    });
  });

  group("zipWithNextTransform", () {
    test("zipWithNextTransform", () {
      final result =
          iterableOf([1, 2, 3, 4, 5]).zipWithNextTransform((a, b) => a + b);
      expect(result, listOf(3, 5, 7, 9));
    });
    test("empty does nothing", () {
      final result = emptyIterable().zipWithNextTransform((a, b) => a + b);
      expect(result, emptyList());
    });
    test("zipWithNextTransform doesn't allow null as transform function", () {
      final iterable = emptyIterable<String>();
      const int Function(dynamic, dynamic) transform = null;
      final e = catchException<ArgumentError>(
          () => iterable.zipWithNextTransform(transform));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });
  });
}
