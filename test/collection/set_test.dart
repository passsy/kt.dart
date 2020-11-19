import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("KtSet", () {
    group("Set", () {
      testSet(setOf, setOf, setFrom, mutable: false);
    });
    group("mutableSet", () {
      testSet(mutableSetOf, mutableSetOf, mutableSetFrom);
    });
    group("hashSet", () {
      testSet(hashSetOf, hashSetOf, hashSetFrom, ordered: false);
    });
    group("linkedSet", () {
      testSet(linkedSetOf, linkedSetOf, linkedSetFrom);
    });
  });

  group("KtSet.of constructor", () {
    test("creates correct size", () {
      final list = KtSet.of("1", "2", "3");
      expect(list.size, 3);
    });
    test("creates empty", () {
      final list = KtSet<String>.of();
      expect(list.isEmpty(), isTrue);
      expect(list.size, 0);
      expect(list, const KtSet.empty());
    });
    test("allows null", () {
      final list = KtSet.of("1", null, "3");
      expect(list.size, 3);
      expect(list.dart, ["1", null, "3"]);
      expect(list, KtSet.from(["1", null, "3"]));
    });
    test("only null is fine", () {
      // ignore: avoid_redundant_argument_values
      final list = KtSet<String?>.of(null);
      expect(list.size, 1);
      expect(list.dart, [null]);
      expect(list, KtSet.from([null]));
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
    KtSet<T> Function<T>(Iterable<T> iterable) setFrom,
    {bool ordered = true,
    bool mutable = true}) {
  test("hashCode is 0", () {
    expect(emptySet().hashCode, 0);
  });

  test("toString is []", () {
    expect(emptySet().toString(), "[]");
  });

  test("empty iterator", () {
    final iterator = setOf().iterator();
    expect(iterator.hasNext(), isFalse);
    expect(() => iterator.next(),
        throwsA(const TypeMatcher<NoSuchElementException>()));
  });

  test("has no elements", () {
    final set = setOf();
    expect(set.size, equals(0));
  });

  test("contains nothing", () {
    final set = setOf<String?>("a", "b", "c");
    expect(set.contains("a"), isTrue);
    expect(set.contains("b"), isTrue);
    expect(set.contains("c"), isTrue);
    expect(set.contains(null), isFalse);
    expect(set.contains(""), isFalse);
    expect(set.contains(null), isFalse);
  });

  test("empty iterator has no next", () {
    final set = setOf();
    final iterator = set.iterator();
    expect(iterator.hasNext(), isFalse);
    expect(() => iterator.next(),
        throwsA(const TypeMatcher<NoSuchElementException>()));
  });

  test("iterator with 1 element has 1 next", () {
    final set = setOf("a");
    final iterator = set.iterator();
    expect(iterator.hasNext(), isTrue);
    expect(iterator.next(), equals("a"));

    expect(iterator.hasNext(), isFalse);
    expect(() => iterator.next(),
        throwsA(const TypeMatcher<NoSuchElementException>()));
  });

  test("iterator with items", () {
    final iterator = setOf(1, 2, 3).iterator();

    expect(iterator.hasNext(), isTrue);
    expect(iterator.next(), isNotNull);
    expect(iterator.hasNext(), isTrue);
    expect(iterator.next(), isNotNull);

    expect(iterator.hasNext(), isTrue);
    expect(iterator.next(), isNotNull);

    expect(iterator.hasNext(), isFalse);
    expect(() => iterator.next(),
        throwsA(const TypeMatcher<NoSuchElementException>()));
  });

  test("is empty", () {
    final set = setOf("asdf");

    expect(set.isEmpty(), isFalse);
    expect(set.isEmpty(), isFalse);
  });

  test("is equal to another set", () {
    final set0 = setOf("a", "b", "c");
    final set1 = setOf("b", "a", "c");
    final set2 = setOf("a", "c");
    final set3 = setOf();

    expect(set0, equals(set1));
    expect(set0.hashCode, equals(set1.hashCode));

    expect(set0, isNot(equals(set2)));
    expect(set0.hashCode, isNot(equals(set2.hashCode)));

    expect(set0, isNot(equals(set3)));
  });

  test("is not equal to other types", () {
    expect(setOf(1, 2, 3), isNot(equals(listOf(1, 2, 3))));
    expect(setOf(1, 2, 3), isNot(equals("a, b, b")));
    expect(setOf(1, 2, 3), isNot(equals(1)));
  });

  test("access dart set", () {
    // ignore: deprecated_member_use_from_same_package
    final Set<String> set = setOf<String>("a", "b", "c").set;
    expect(set.length, 3);
    expect(set, equals({"a", "b", "c"}));
  });

  test("equals although differnt types (subtypes)", () {
    expect(setOf<int>(1, 2, 3), setOf<num>(1, 2, 3));
    expect(setOf<num>(1, 2, 3), setOf<int>(1, 2, 3));
  });

  if (mutable) {
    test("emptySet, asSet allows mutation - empty", () {
      final ktSet = emptySet<String>();
      expect(ktSet.isEmpty(), isTrue);
      final dartSet = ktSet.asSet();
      dartSet.add("asdf");
      expect(dartSet.length, 1);
      expect(ktSet.size, 1);
    });

    test("empty mutable set, asSet allows mutation", () {
      final ktSet = setOf<String>();
      expect(ktSet.isEmpty(), isTrue);
      final dartSet = ktSet.asSet();
      dartSet.add("asdf");
      expect(dartSet.length, 1);
      expect(ktSet.size, 1);
    });

    test("mutable set, asSet allows mutation", () {
      final ktSet = setOf("a");
      final dartSet = ktSet.asSet();
      dartSet.add("asdf");
      expect(dartSet.length, 2);
      expect(ktSet.size, 2);
    });
  } else {
    test("emptySet, asSet doesn't allow mutation", () {
      final ktSet = emptySet();
      expect(ktSet.isEmpty(), isTrue);
      final e =
          catchException<UnsupportedError>(() => ktSet.asSet().add("asdf"));
      expect(e.message, contains("unmodifiable"));
    });

    test("empty set, asSet doesn't allows mutation", () {
      final ktSet = setOf<String>();
      expect(ktSet.isEmpty(), isTrue);
      final e =
          catchException<UnsupportedError>(() => ktSet.asSet().add("asdf"));
      expect(e.message, contains("unmodifiable"));
    });

    test("set, asSet doesn't allows mutation", () {
      final ktSet = setOf<String>("a");
      final e =
          catchException<UnsupportedError>(() => ktSet.asSet().add("asdf"));
      expect(e.message, contains("unmodifiable"));
    });
  }
}
