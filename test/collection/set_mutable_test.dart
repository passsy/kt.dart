import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("KtMutableSet", () {
    group("mutableSet", () {
      testMutableSet(
          <T>() => KtMutableSet.empty(), mutableSetOf, mutableSetFrom);
    });
    group("hashSet", () {
      testMutableSet(<T>() => KtHashSet.empty(), hashSetOf, hashSetFrom,
          ordered: false);
    });
    group("linkedSet", () {
      testMutableSet(<T>() => KtLinkedSet.empty(), linkedSetOf, linkedSetFrom);
    });
  });

  group("KtMutableSet.of constructor", () {
    test("creates correct size", () {
      final list = KtMutableSet.of("1", "2", "3");
      expect(list.size, 3);
    });
    test("creates empty", () {
      final list = KtMutableSet<String>.of();
      expect(list.isEmpty(), isTrue);
      expect(list.size, 0);
      expect(list, emptySet<String>());
    });
    test("allows null", () {
      final list = KtMutableSet.of("1", null, "3");
      expect(list.size, 3);
      expect(list.dart, ["1", null, "3"]);
      expect(list, KtSet.from(["1", null, "3"]));
    });
    test("only null is fine", () {
      // ignore: avoid_redundant_argument_values
      final list = KtMutableSet<String?>.of(null);
      expect(list.size, 1);
      expect(list.dart, [null]);
      expect(list, KtSet.from([null]));
    });
  });
}

void testMutableSet(
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
    KtMutableSet<T> Function<T>(Iterable<T> iterable) mutableSetFrom,
    {bool ordered = true}) {
  test("mutableSetOf automatically removes duplicates", () {
    final set = mutableSetOf("a", "b", "a", "c");
    expect(set.size, 3);
  });

  test("hashSetOf automatically removes duplicates", () {
    final set = hashSetOf("a", "b", "a", "c");
    expect(set.size, 3);
  });

  test("iterator().remove() removes last returned element", () {
    final set = mutableSetOf("a", "b", "c");
    final iterator = set.iterator();
    final lastReturnedValue = iterator.next();
    iterator.remove();

    expect(set.contains(lastReturnedValue), false);
  });

  test("iterator().remove() throws when there is no last returned value", () {
    final set = mutableSetOf("a", "b", "c");
    final iterator = set.iterator();
    final e = catchException(() => iterator.remove());

    expect(e, const TypeMatcher<StateError>());
  });

  test("iterator().remove() throws when called multiple times in a row", () {
    final set = mutableSetOf("a", "b", "c");
    final iterator = set.iterator();
    iterator.next();
    iterator.next();
    iterator.remove();
    final e = catchException(() => iterator.remove());

    expect(e, const TypeMatcher<StateError>());
  });

  if (ordered) {
    test("mutableSetOf iterates in order as specified", () {
      final set = mutableSetOf("a", "b", "c");
      final iterator = set.iterator();
      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), "a");
      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), "b");
      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), "c");
      expect(iterator.hasNext(), isFalse);
      final e = catchException(() => iterator.next());
      expect(e, const TypeMatcher<NoSuchElementException>());
    });
  } else {
    test("throws at end", () {
      final set = mutableSetOf("a", "b", "c");
      final iterator = set.iterator();
      expect(iterator.hasNext(), isTrue);
      iterator.next();
      expect(iterator.hasNext(), isTrue);
      iterator.next();
      expect(iterator.hasNext(), isTrue);
      iterator.next();
      expect(iterator.hasNext(), isFalse);
      final e = catchException(() => iterator.next());
      expect(e, const TypeMatcher<NoSuchElementException>());
    });
  }

  test("using the internal dart set allows mutation - empty", () {
    final set = emptySet();
    expect(set.isEmpty(), isTrue);
    // ignore: deprecated_member_use_from_same_package
    set.set.add("asdf");
    // unchanged
    expect(set.isEmpty(), isFalse);
    expect(set, setOf("asdf"));
  });

  test("using the internal dart set allows mutation", () {
    final kset = mutableSetOf("a");
    expect(kset, setOf("a"));
    // ignore: deprecated_member_use_from_same_package
    kset.set.add("b");
    // unchanged
    expect(kset, setOf("a", "b"));
  });

  test("clear", () {
    final list = mutableSetOf(["a", "b", "c"]);
    list.clear();
    expect(list.isEmpty(), isTrue);
  });

  group("remove", () {
    test("remove item when found", () {
      final list = mutableSetOf("a", "b", "c");
      final result = list.remove("b");
      expect(list, setOf("a", "c"));
      expect(result, isTrue);
    });
    test("don't remove item when not found", () {
      final list = mutableSetOf("a", "b", "c");
      final result = list.remove("x");
      expect(list, setOf("a", "b", "c"));
      expect(result, isFalse);
    });
  });

  group("removeAll", () {
    test("remove item when found", () {
      final list = mutableSetOf("paul", "john", "max", "lisa");
      final result = list.removeAll(listOf("paul", "max"));
      expect(list, setOf("john", "lisa"));
      expect(result, isTrue);
    });
    test("remove only found when found", () {
      final list = mutableSetOf("paul", "john", "max", "lisa");
      final result = list.removeAll(listOf("paul", "max", "tony"));
      expect(list, setOf("john", "lisa"));
      expect(result, isTrue);
    });
  });
}
