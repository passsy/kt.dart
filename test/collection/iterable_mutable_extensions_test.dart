import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/iterable.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group("mutableIterable", () {
    testIterable(<T>() => DartMutableIterable<T>([]),
        <T>(Iterable<T> iterable) => DartMutableIterable(iterable));
  });
  group("mutableList", () {
    testIterable(<T>() => mutableListOf<T>(),
        <T>(Iterable<T> iterable) => mutableListOf(iterable));
  });

  group("hashset", () {
    testIterable(<T>() => hashSetOf<T>(),
        <T>(Iterable<T> iterable) => hashSetOf(iterable),
        ordered: false);
  });
  group("linkedSet", () {
    testIterable(<T>() => linkedSetOf<T>(),
        <T>(Iterable<T> iterable) => linkedSetOf(iterable));
  });
}

void testIterable(KMutableIterable<T> Function<T>() emptyIterable,
    KMutableIterable<T> Function<T>(Iterable<T> iterable) mutableIterableOf,
    {bool ordered = true}) {
  group("removal functions throw", () {});

  group("removeAllWhere", () {
    test("removeAllWhere", () {
      final iterable = mutableIterableOf(["paul", "john", "max", "lisa"]);
      final e = catchException(
          () => iterable.removeAllWhere((it) => it.endsWith("x")));
      // TODO remove error assertion once implemented
      expect(e, const TypeMatcher<UnimplementedError>());
      //expect(iterable.toList(), listOf(["paul", "john", "lisa"]));
    });

    test("removeAllWhere requires predicate to be non null", () {
      final e = catchException<ArgumentError>(
          () => emptyIterable().removeAllWhere(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("retainAllWhere", () {
    test("retainAllWhere", () {
      final iterable = mutableIterableOf(["paul", "john", "max", "lisa"]);
      final e = catchException(
          () => iterable.retainAllWhere((it) => it.endsWith("x")));
      // TODO remove error assertion once implemented
      expect(e, const TypeMatcher<UnimplementedError>());
      //expect(iterable.toList(), listOf(["max"]));
    });

    test("retainAllWhere requires predicate to be non null", () {
      final e = catchException<ArgumentError>(
          () => emptyIterable().retainAllWhere(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });
}
