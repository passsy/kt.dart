import "package:kt_dart/collection.dart";
import "package:test/test.dart";

void main() {
  group("KtMutableSetExtensions", () {
    group("KtMutableSet", () {
      testSet(
        emptySet: <T>() => KtMutableSet<T>.empty(),
        mutableSetOf: <T>(
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
        mutableSetFrom: <T>([Iterable<T> iterable = const []]) =>
            KtMutableSet.from(iterable),
      );
    });
    group("mutableSet", () {
      testSet(
        emptySet: <T>() => mutableSetOf<T>(),
        mutableSetOf: <T>(
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
        mutableSetFrom: <T>([Iterable<T> iterable = const []]) =>
            mutableSetFrom(iterable),
      );
    });

    group("KtHashSet", () {
      testSet(
        emptySet: <T>() => KtHashSet<T>.empty(),
        mutableSetOf: <T>(
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
        mutableSetFrom: <T>([Iterable<T> iterable = const []]) =>
            KtHashSet.from(iterable),
      );
    });
    group("hashSet", () {
      testSet(
        emptySet: <T>() => hashSetOf<T>(),
        mutableSetOf: <T>(
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
            hashSetOf(
                arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
        mutableSetFrom: <T>([Iterable<T> iterable = const []]) =>
            hashSetFrom(iterable),
      );
    });

    group("KtLinkedSet", () {
      testSet(
        emptySet: <T>() => KtLinkedSet<T>.empty(),
        mutableSetOf: <T>(
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
        mutableSetFrom: <T>([Iterable<T> iterable = const []]) =>
            KtLinkedSet.from(iterable),
      );
    });
    group("linkedSet", () {
      testSet(
        emptySet: <T>() => linkedSetOf<T>(),
        mutableSetOf: <T>(
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
        mutableSetFrom: <T>([Iterable<T> iterable = const []]) =>
            linkedSetFrom(iterable),
      );
    });
  });
}

void testSet({
  KtMutableSet<T> Function<T>() emptySet,
  KtMutableSet<T> Function<T>(
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
      mutableSetOf,
  KtMutableSet<T> Function<T>([Iterable<T> iterable]) mutableSetFrom,
}) {
  group("dart property", () {
    test("dart property returns an empty list", () {
      final dartList = emptySet<int>().dart;
      expect(dartList.length, 0);
    });

    test("dart property returns an modifiable list", () {
      final original = mutableSetOf<int>();
      final dartList = original.dart;
      dartList.add(1);
      expect(original, mutableSetOf(1));
      expect(dartList, {1});
    });
  });
}
