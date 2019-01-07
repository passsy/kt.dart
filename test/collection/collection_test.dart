import 'dart:math' as math show Random;

import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group("list", () {
    testCollection(<T>() => emptyList<T>(),
        <T>(Iterable<T> iterable) => listFrom(iterable));
  });
  group("KList", () {
    testCollection(<T>() => KList<T>.empty(),
        <T>(Iterable<T> iterable) => KList.from(iterable));
  });
  group("mutableList", () {
    testCollection(<T>() => mutableListOf<T>(),
        <T>(Iterable<T> iterable) => mutableListFrom(iterable));
  });
  group("KMutableList", () {
    testCollection(<T>() => KMutableList<T>.empty(),
        <T>(Iterable<T> iterable) => KMutableList.from(iterable));
  });
  group("set", () {
    testCollection(
        <T>() => emptySet<T>(), <T>(Iterable<T> iterable) => setFrom(iterable));
  });
  group("KSet", () {
    testCollection(<T>() => KSet<T>.empty(),
        <T>(Iterable<T> iterable) => KSet.from(iterable));
  });
  group("hashset", () {
    testCollection(<T>() => hashSetOf<T>(),
        <T>(Iterable<T> iterable) => hashSetFrom(iterable),
        ordered: false);
  });
  group("KHashSet", () {
    testCollection(<T>() => KHashSet<T>.empty(),
        <T>(Iterable<T> iterable) => KHashSet.from(iterable),
        ordered: false);
  });
  group("linkedSet", () {
    testCollection(<T>() => linkedSetOf<T>(),
        <T>(Iterable<T> iterable) => linkedSetFrom(iterable));
  });
  group("KLinkedSet", () {
    testCollection(<T>() => KLinkedSet<T>.empty(),
        <T>(Iterable<T> iterable) => KLinkedSet.from(iterable));
  });
}

void testCollection(KCollection<T> Function<T>() emptyCollection,
    KCollection<T> Function<T>(Iterable<T> collection) collectionOf,
    {bool ordered = true}) {
  group('contains', () {
    test("no elements", () {
      var list = emptyCollection<String>();
      expect(list.contains("a"), isFalse);
      expect(list.contains(null), isFalse);
    });

    test("contains", () {
      var list = collectionOf(["a", "b", "c", "d", "e"]);
      expect(list.contains("a"), isTrue);
      expect(list.contains("e"), isTrue);
    });

    test("does not contain", () {
      var list = collectionOf(["a", "b", "c", "d", "e"]);
      expect(list.contains("x"), isFalse);
      expect(list.contains(null), isFalse);
    });
  });

  group('containsAll', () {
    test("no elements", () {
      var list = emptyCollection<String>();
      expect(list.containsAll(listOf("a")), isFalse);
      expect(list.containsAll(listOf()), isTrue);
    });

    test("contains all", () {
      var list = collectionOf(["a", "b", "c", "d", "e"]);
      expect(list.containsAll(listOf("a")), isTrue);
      expect(list.containsAll(listOf("c", "d")), isTrue);
    });

    test("doesn't contain all", () {
      var list = collectionOf(["a", "b", "c", "d", "e"]);
      expect(list.containsAll(listOf("x")), isFalse);
      expect(list.containsAll(listOf("c", "x", "d")), isFalse);
    });

    test("containsAll doesn't allow null as argument", () {
      final collection = collectionOf(["a", "b", "c", "d", "e"]);
      final e =
          catchException<ArgumentError>(() => collection.containsAll(null));
      expect(e.message, allOf(contains("null"), contains("elements")));
    });

    test("containsAll (empty collection) doesn't allow null as argument", () {
      final e = catchException<ArgumentError>(
          () => emptyCollection().containsAll(null));
      expect(e.message, allOf(contains("null"), contains("elements")));
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

  group("random", () {
    test("random item with random parameter", () {
      final collection = collectionOf(["a", "b", "c"]);

      final firstPick = collection.random((NotRandom()..next = 2));
      final pos2 = collection.elementAt(2);
      if (ordered) expect(pos2, "c");

      expect(firstPick, pos2);

      final pos0 = collection.elementAt(0);
      if (ordered) expect(pos0, "a");

      final secondPick = collection.random((NotRandom()..next = 0));
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
