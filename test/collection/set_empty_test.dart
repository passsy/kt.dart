import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group("emptySet", () {
    testEmptySet(<T>() => emptySet<T>());
  });
  group("KSet.empty", () {
    testEmptySet(<T>() => KSet<T>.empty());
  });
  group("KSet.of", () {
    testEmptySet(<T>() => KSet<T>.of());
  });
  group("KSet.from", () {
    testEmptySet(<T>() => KSet<T>.from());
  });
  group("mutableSetFrom", () {
    testEmptySet(<T>() => mutableSetFrom<T>(), mutable: true);
  });
  group("mutableSetOf", () {
    testEmptySet(<T>() => mutableSetOf<T>(), mutable: true);
  });
  group("KMutableSet.of", () {
    testEmptySet(<T>() => KMutableSet<T>.of(), mutable: true);
  });
  group("KMutableSet.from", () {
    testEmptySet(<T>() => KMutableSet<T>.from(), mutable: true);
  });
  group("KHashSet.from", () {
    testEmptySet(<T>() => KHashSet<T>.from(), mutable: true);
  });
  group("KHashSet.of", () {
    testEmptySet(<T>() => KHashSet<T>.of(), mutable: true);
  });
  group("KLinkedSet.from", () {
    testEmptySet(<T>() => KLinkedSet<T>.from(), mutable: true);
  });
  group("KLinkedSet.of", () {
    testEmptySet(<T>() => KLinkedSet<T>.of(), mutable: true);
  });
}

void testEmptySet(KSet<T> Function<T>() emptySet, {bool mutable = false}) {
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
