import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("KtSetExtensions", () {
    group("Set", () {
      // ignore: prefer_const_constructors
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
      const KtSet<int>? set = null;
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

  group("minus", () {
    test("remove iterable", () {
      final result =
          setOf("paul", "john", "max", "lisa").minus(setOf("max", "john"));
      expect(result, setOf("paul", "lisa"));
    });
    test("infix", () {
      final result = setOf("paul", "john", "max", "lisa") - setOf("max");
      expect(result.toSet(), setOf("paul", "john", "lisa"));
    });
    test("empty gets returned empty", () {
      final result = emptySet<String>() - setOf("max");
      expect(result.toList(), emptyList());
    });
  });

  group("minusElement", () {
    test("remove one item", () {
      final result = setOf("paul", "john", "max", "lisa").minusElement("max");
      expect(result.toSet(), setOf("paul", "john", "lisa"));
    });
  });

  group("plus", () {
    test("concat two iterables", () {
      final result = setOf(1, 2, 3).plus(setOf(4, 5, 6));
      expect(result, setOf(1, 2, 3, 4, 5, 6));
    });
    test("infix", () {
      final result = setOf(1, 2, 3) + setOf(4, 5, 6);
      expect(result, setOf(1, 2, 3, 4, 5, 6));
    });
  });

  group("plusElement", () {
    test("concat item", () {
      final result = setOf(1, 2, 3).plusElement(5);
      expect(result, setOf(1, 2, 3, 5));
    });
    test("element can be null", () {
      final result = setOf<int?>(1, 2, 3).plusElement(null);
      expect(result, setOf(1, 2, 3, null));
    });
  });
}
