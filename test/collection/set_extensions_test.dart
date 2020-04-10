import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("KtSetExtensions", () {
    group("Set", () {
      testSet(<T>() => KtSet.empty(), setOf, setFrom);
    });
    group("mutableSet", () {
      testSet(<T>() => KtMutableSet.empty(), mutableSetOf, mutableSetFrom,
          mutable: true);
    });
    group("hashSet", () {
      testSet(<T>() => KtHashSet.empty(), hashSetOf, hashSetFrom,
          mutable: true);
    });
    group("linkedSet", () {
      testSet(<T>() => KtLinkedSet.empty(), linkedSetOf, linkedSetFrom,
          mutable: true);
    });
  });
}

void testSet(
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
  KtSet<T> Function<T>([Iterable<T> iterable]) setFrom, {
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
