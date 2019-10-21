import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import '../test/assert_dart.dart';

void main() {
  group("KtSet", () {
    testSet(
      emptySet: <T>() => KtSet<T>.empty(),
      setOf: <T>(
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
          KtSet<T>.of(
              arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
      setFrom: <T>([Iterable<T> iterable = const []]) => KtSet.from(iterable),
      mutable: false,
    );
  });
  group("set", () {
    testSet(
      emptySet: <T>() => emptySet<T>(),
      setOf: <T>(
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
          setOf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
      setFrom: <T>([Iterable<T> iterable = const []]) => setFrom(iterable),
      mutable: false,
    );
  });
  group("KtMutableSet", () {
    testSet(
      emptySet: <T>() => KtMutableSet<T>.empty(),
      setOf: <T>(
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
          KtMutableSet<T>.of(
              arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
      setFrom: <T>([Iterable<T> iterable = const []]) =>
          KtMutableSet.from(iterable),
      mutable: true,
    );
  });
  group("mutableSet", () {
    testSet(
      emptySet: <T>() => mutableSetOf<T>(),
      setOf: <T>(
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
          mutableSetOf(
              arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
      setFrom: <T>([Iterable<T> iterable = const []]) =>
          mutableSetFrom(iterable),
      mutable: true,
    );
  });

  group("KtHashSet", () {
    testSet(
      emptySet: <T>() => KtHashSet<T>.empty(),
      setOf: <T>(
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
          KtHashSet<T>.of(
              arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
      setFrom: <T>([Iterable<T> iterable = const []]) =>
          KtHashSet.from(iterable),
      mutable: true,
    );
  });
  group("hashSet", () {
    testSet(
      emptySet: <T>() => hashSetOf<T>(),
      setOf: <T>(
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
          hashSetOf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
      setFrom: <T>([Iterable<T> iterable = const []]) => hashSetFrom(iterable),
      mutable: true,
    );
  });

  group("KtLinkedSet", () {
    testSet(
      emptySet: <T>() => KtLinkedSet<T>.empty(),
      setOf: <T>(
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
          KtLinkedSet<T>.of(
              arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
      setFrom: <T>([Iterable<T> iterable = const []]) =>
          KtLinkedSet.from(iterable),
      mutable: true,
    );
  });
  group("linkedSet", () {
    testSet(
      emptySet: <T>() => linkedSetOf<T>(),
      setOf: <T>(
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
          linkedSetOf(
              arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
      setFrom: <T>([Iterable<T> iterable = const []]) =>
          linkedSetFrom(iterable),
      mutable: true,
    );
  });
}

void testSet({
  KtSet<T> Function<T>() emptySet,
  KtSet<T> Function<T>(
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
      setOf,
  KtSet<T> Function<T>([Iterable<T> iterable]) setFrom,
  bool mutable = false,
}) {
  group("dart property", () {
    test("dart property returns an empty list", () {
      final dartList = emptySet<int>().dart;
      expect(dartList.length, 0);
    });

    if (!mutable) {
      test("dart property returns an unmodifiable list", () {
        final dartList = emptySet<int>().dart;
        final e = catchException<UnsupportedError>(() => dartList.add(1));
        expect(e.message, contains("unmodifiable"));
      });
    } else {
      test("dart property returns an modifiable list", () {
        final original = setOf<int>();
        final dartList = original.dart;
        dartList.add(1);
        expect(original, setOf(1));
        expect(dartList, {1});
      });
    }
  });

  group("orEmpty", () {
    test("null -> empty set", () {
      const KtSet<int> set = null;
      expect(set.orEmpty(), isNotNull);
      expect(set.orEmpty(), isA<KtSet<int>>());
      expect(set.orEmpty().isEmpty(), isTrue);
      expect(set.orEmpty().size, 0);
    });
    test("set -> just return the set", () {
      final KtSet<int> set = setOf(1, 2, 3);
      expect(set.orEmpty(), set);
      expect(identical(set.orEmpty(), set), isTrue);
    });
  });
}
