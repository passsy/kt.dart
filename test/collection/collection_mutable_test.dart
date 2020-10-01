import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("KtMutableCollection", () {
    group("mutableList", () {
      testCollection(<T>() => mutableListOf<T>(),
          <T>(Iterable<T> iterable) => mutableListFrom(iterable));
    });
    group("KtMutableList", () {
      testCollection(<T>() => KtMutableList<T>.empty(),
          <T>(Iterable<T> iterable) => KtMutableList.from(iterable));
    });
    group("hashset", () {
      testCollection(<T>() => hashSetOf<T>(),
          <T>(Iterable<T> iterable) => hashSetFrom(iterable),
          ordered: false);
    });
    group("KtHashSet", () {
      testCollection(<T>() => KtHashSet<T>.empty(),
          <T>(Iterable<T> iterable) => KtHashSet.from(iterable),
          ordered: false);
    });
    group("linkedSet", () {
      testCollection(<T>() => linkedSetOf<T>(),
          <T>(Iterable<T> iterable) => linkedSetFrom(iterable));
    });
    group("KtLinkedSet", () {
      testCollection(<T>() => KtLinkedSet<T>.empty(),
          <T>(Iterable<T> iterable) => KtLinkedSet.from(iterable));
    });
  });
}

void testCollection(
    KtMutableCollection<T> Function<T>() emptyCollection,
    KtMutableCollection<T> Function<T>(Iterable<T> collection)
        mutableCollectionOf,
    {bool ordered = true}) {
  group("add", () {
    test("add a item", () {
      final list = mutableCollectionOf(["a"]);
      list.add("b");
      expect(list.size, equals(2));
      expect(list, equals(mutableCollectionOf(["a", "b"])));
    });
    test("add null works", () {
      final list = mutableCollectionOf(["a"]);
      list.add(null);
      expect(list.size, equals(2));
      expect(list, equals(mutableCollectionOf(["a", null])));
    });
  });
  group("addAll", () {
    test("add all items", () {
      final list = mutableCollectionOf(["a"]);
      list.addAll(listOf("b", "c"));
      expect(list.size, equals(3));
      expect(list, equals(mutableCollectionOf(["a", "b", "c"])));
    });
    test("addAll doens't allow null as defaultValue function", () {
      final collection = emptyCollection();
      final e = catchException<ArgumentError>(() => collection.addAll(null));
      expect(e.message, allOf(contains("null"), contains("elements")));
    });
  });

  group("removeAll", () {
    test("remove items", () {
      final list = mutableCollectionOf(["a", "b", "c", "d"]);
      list.removeAll(listOf("b", "c"));
      expect(list, mutableCollectionOf(["a", "d"]));
    });
    test("elements can't be null", () {
      final e =
          catchException<ArgumentError>(() => mutableListOf().removeAll(null));
      expect(e.message, allOf(contains("null"), contains("elements")));
    });
  });

  group("retainAll", () {
    test("retain items", () {
      final list = mutableCollectionOf(["a", "b", "c", "d", "a", "b"]);
      list.retainAll(listOf("b", "c"));
      expect(list, mutableCollectionOf(["b", "c", "b"]));
    });

    test("elements can't be null", () {
      final e =
          catchException<ArgumentError>(() => mutableListOf().retainAll(null));
      expect(e.message, allOf(contains("null"), contains("elements")));
    });
  });

  group("toString", () {
    test("recursive list with self reference prints nicely", () {
      final self = mutableCollectionOf<dynamic>([]);
      self.add(self);
      expect(self.toString(), "[(this Collection)]");
    });
  });
}
