import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/iterable.dart";
import "package:test/test.dart";

void main() {
  group("KtMutableIterableExtensions", () {
    group("mutableIterable", () {
      testIterable(<T>() => DartMutableIterable<T>([]),
          <T>(Iterable<T> iterable) => DartMutableIterable(iterable.toList()));
    });
    group("mutableList", () {
      testIterable(<T>() => mutableListOf<T>(),
          <T>(Iterable<T> iterable) => mutableListFrom(iterable));
    });

    group("hashset", () {
      testIterable(<T>() => hashSetOf<T>(),
          <T>(Iterable<T> iterable) => hashSetFrom(iterable),
          ordered: false);
    });
    group("KtHashSet", () {
      testIterable(<T>() => KtHashSet<T>.of(),
          <T>(Iterable<T> iterable) => KtHashSet<T>.from(iterable));
    });

    group("linkedSet", () {
      testIterable(<T>() => linkedSetOf<T>(),
          <T>(Iterable<T> iterable) => linkedSetFrom(iterable));
    });
    group("KtHashSet", () {
      testIterable(<T>() => KtLinkedSet<T>.of(),
          <T>(Iterable<T> iterable) => KtLinkedSet<T>.from(iterable));
    });

    test("DartMutableIterable exposes dart Iterable via iter", () {
      final dartIterable = [];
      final exposedIter = DartMutableIterable(dartIterable).iter;
      expect(identical(dartIterable, exposedIter), isTrue);
    });
  });
}

void testIterable(KtMutableIterable<T> Function<T>() emptyIterable,
    KtMutableIterable<T> Function<T>(Iterable<T> iterable) mutableIterableOf,
    {bool ordered = true}) {
  group("removal functions throw", () {});

  group("removeAllWhere", () {
    test("removeAllWhere", () {
      final list = mutableListOf("paul", "john", "max", "lisa");
      list.removeAllWhere((it) => it.endsWith("x"));
      
      expect(list, listOf("paul", "john", "lisa"));
    });
  });

  group("retainAllWhere", () {
    test("retainAllWhere", () {
      final list = mutableListOf("paul", "john", "max", "lisa");
      list.retainAllWhere((it) => it.endsWith("x"));
      
      expect(list, listOf("max"));
    });
  });
}
