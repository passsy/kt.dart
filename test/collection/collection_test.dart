import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group("list", () {
    testCollection(
        <T>() => emptyList<T>(), <T>(Iterable<T> iterable) => listOf(iterable));
  });
  group("mutableList", () {
    testCollection(<T>() => emptyList<T>(),
        <T>(Iterable<T> iterable) => mutableListOf(iterable));
  });
  group("set", () {
    testCollection(
        <T>() => emptySet<T>(), <T>(Iterable<T> iterable) => setOf(iterable));
  });
  group("hashset", () {
    testCollection(<T>() => emptySet<T>(),
        <T>(Iterable<T> iterable) => hashSetOf(iterable),
        ordered: false);
  });
  group("linkedSet", () {
    testCollection(<T>() => emptySet<T>(),
        <T>(Iterable<T> iterable) => linkedSetOf(iterable));
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
      expect(list.containsAll(listOf(["a"])), isFalse);
      expect(list.containsAll(listOf([])), isTrue);
    });

    test("contains all", () {
      var list = collectionOf(["a", "b", "c", "d", "e"]);
      expect(list.containsAll(listOf(["a"])), isTrue);
      expect(list.containsAll(listOf(["c", "d"])), isTrue);
    });

    test("doesn't contain all", () {
      var list = collectionOf(["a", "b", "c", "d", "e"]);
      expect(list.containsAll(listOf(["x"])), isFalse);
      expect(list.containsAll(listOf(["c", "x", "d"])), isFalse);
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
}
