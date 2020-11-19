import "dart:math" as math show Random;

import "package:kt_dart/collection.dart";
import "package:test/test.dart";

void main() {
  group("KtCollection", () {
    group("list", () {
      testCollection(<T>() => emptyList<T>(),
          <T>(Iterable<T> iterable) => listFrom(iterable));
    });
    group("KtList", () {
      testCollection(<T>() => KtList<T>.empty(),
          <T>(Iterable<T> iterable) => KtList.from(iterable));
    });
    group("mutableList", () {
      testCollection(<T>() => mutableListOf<T>(),
          <T>(Iterable<T> iterable) => mutableListFrom(iterable));
    });
    group("KtMutableList", () {
      testCollection(<T>() => KtMutableList<T>.empty(),
          <T>(Iterable<T> iterable) => KtMutableList.from(iterable));
    });
    group("set", () {
      testCollection(<T>() => emptySet<T>(),
          <T>(Iterable<T> iterable) => setFrom(iterable));
    });
    group("KtSet", () {
      testCollection(<T>() => KtSet<T>.empty(),
          <T>(Iterable<T> iterable) => KtSet.from(iterable));
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

void testCollection(KtCollection<T> Function<T>() emptyCollection,
    KtCollection<T> Function<T>(Iterable<T> collection) collectionOf,
    {bool ordered = true}) {
  group("contains", () {
    test("no elements", () {
      final list = emptyCollection<String?>();
      expect(list.contains("a"), isFalse);
      expect(list.contains(null), isFalse);
    });

    test("contains", () {
      final list = collectionOf(["a", "b", "c", "d", "e"]);
      expect(list.contains("a"), isTrue);
      expect(list.contains("e"), isTrue);
    });

    test("does not contain", () {
      final list = collectionOf<String?>(["a", "b", "c", "d", "e"]);
      expect(list.contains("x"), isFalse);
      expect(list.contains(null), isFalse);
    });
  });

  group("containsAll", () {
    test("no elements", () {
      final list = emptyCollection<String>();
      expect(list.containsAll(listOf("a")), isFalse);
      expect(list.containsAll(listOf<String>()), isTrue);
    });

    test("contains all", () {
      final list = collectionOf(["a", "b", "c", "d", "e"]);
      expect(list.containsAll(listOf("a")), isTrue);
      expect(list.containsAll(listOf("c", "d")), isTrue);
    });

    test("doesn't contain all", () {
      final list = collectionOf(["a", "b", "c", "d", "e"]);
      expect(list.containsAll(listOf("x")), isFalse);
      expect(list.containsAll(listOf("c", "x", "d")), isFalse);
    });
  });

  group("isNotEmpty", () {
    test("is empty", () {
      expect(collectionOf([]).isNotEmpty(), false);
    });
    test("is not empty", () {
      expect(collectionOf(["a"]).isNotEmpty(), true);
    });
  });

  group("orEmpty", () {
    test("null -> empty collection", () {
      const KtCollection<int>? collection = null;
      expect(collection.orEmpty(), isNotNull);
      expect(collection.orEmpty(), isA<KtCollection<int>>());
      expect(collection.orEmpty().isEmpty(), isTrue);
      expect(collection.orEmpty().size, 0);
    });
    test("collection -> just return the collection", () {
      final KtCollection<int> collection = collectionOf([1, 2, 3]);
      expect(collection.orEmpty(), collection);
      expect(identical(collection.orEmpty(), collection), isTrue);
    });
  });

  group("random", () {
    test("random item with random parameter", () {
      final collection = collectionOf(["a", "b", "c"]);

      final firstPick = collection.random(NotRandom()..next = 2);
      final pos2 = collection.elementAt(2);
      if (ordered) expect(pos2, "c");

      expect(firstPick, pos2);

      final pos0 = collection.elementAt(0);
      if (ordered) expect(pos0, "a");

      final secondPick = collection.random(NotRandom()..next = 0);
      expect(secondPick, pos0);
    });

    test("random works without passing a Random", () {
      final collection = collectionOf(["a", "b", "c"]);
      expect(collection.random(), anyOf(equals("a"), equals("b"), equals("c")));
    });
  });

  group("toString", () {
    if (ordered) {
      test("default string representation", () {
        final collection = collectionOf(["a", "b", "c"]);
        expect(collection.toString(), "[a, b, c]");
      });
    } else {
      test("unordered collection", () {
        final collection = collectionOf(["a", "b", "c"]);
        expect(
            collection.toString(),
            anyOf(
              equals("[a, b, c]"),
              equals("[a, c, b]"),
              equals("[b, c, a]"),
              equals("[b, a, c]"),
              equals("[c, a, b]"),
              equals("[c, b, a]"),
            ));
      });
    }
  });
}

/// Mocked [math.Random] number generator allow setting the [next] value explicitly
///
/// Using a seed is not enough because it might change in other dart releases
class NotRandom implements math.Random {
  int next = 0;

  @override
  bool nextBool() {
    throw UnimplementedError();
  }

  @override
  double nextDouble() {
    throw UnimplementedError();
  }

  @override
  int nextInt(int max) => next;
}
