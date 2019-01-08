import 'package:kt_stdlib/collection.dart';
import 'package:test/test.dart';

void main() {
  group("emptySet", () {
    testEmptySet(<T>() => emptySet<T>());
  });
  group("KtSet.empty", () {
    testEmptySet(<T>() => KtSet<T>.empty());
  });
  group("KtSet.of", () {
    testEmptySet(<T>() => KtSet<T>.of());
  });
  group("KtSet.from", () {
    testEmptySet(<T>() => KtSet<T>.from());
  });
  group("mutableSetFrom", () {
    testEmptySet(<T>() => mutableSetFrom<T>(), mutable: true);
  });
  group("mutableSetOf", () {
    testEmptySet(<T>() => mutableSetOf<T>(), mutable: true);
  });
  group("KMutableSet.of", () {
    testEmptySet(<T>() => KtMutableSet<T>.of(), mutable: true);
  });
  group("KMutableSet.from", () {
    testEmptySet(<T>() => KtMutableSet<T>.from(), mutable: true);
  });
  group("KHashSet.from", () {
    testEmptySet(<T>() => KtHashSet<T>.from(), mutable: true);
  });
  group("KHashSet.of", () {
    testEmptySet(<T>() => KtHashSet<T>.of(), mutable: true);
  });
  group("KLinkedSet.from", () {
    testEmptySet(<T>() => KtLinkedSet<T>.from(), mutable: true);
  });
  group("KLinkedSet.of", () {
    testEmptySet(<T>() => KtLinkedSet<T>.of(), mutable: true);
  });
}

void testEmptySet(KtSet<T> Function<T>() emptySet, {bool mutable = false}) {
  group('basic methods', () {
    test("empty iterator", () {
      final iterator = emptySet().iterator();
      expect(iterator.hasNext(), isFalse);
      expect(() => iterator.next(),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("contains nothing", () {
      final set = emptySet();
      expect(set.contains("a"), isFalse);
      expect(set.contains("b"), isFalse);
      expect(set.contains("c"), isFalse);
      expect(set.contains(null), isFalse);
      expect(set.contains(""), isFalse);
    });

    test("is empty", () {
      expect(emptySet().isEmpty(), isTrue);
    });
    test("equals although differnt types (subtypes)", () {
      expect(emptySet<int>(), emptySet<num>());
      expect(emptySet<num>(), emptySet<int>());
    });

    if (!mutable) {
      test("using the dart set doesn't allow mutation - empty", () {
        final kset = emptySet();
        expect(kset.isEmpty(), isTrue);
        kset.set.add("asdf");
        // unchanged
        expect(kset.isEmpty(), isTrue);
      });
    }
  });
}
