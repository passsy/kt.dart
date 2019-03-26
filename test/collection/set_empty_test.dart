import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

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

    if (mutable) {
      test("empty set asSet allows mutation", () {
        final ktSet = emptySet();
        expect(ktSet.isEmpty(), isTrue);
        final dartSet = ktSet.asSet();
        dartSet.add("asdf");
        expect(dartSet.length, 1);
        expect(ktSet.size, 1);
      });

      test("empty set set allows mutation", () {
        final ktSet = emptySet();
        expect(ktSet.isEmpty(), isTrue);
        final dartSet = ktSet.set;
        dartSet.add("asdf");
        expect(dartSet.length, 1);
        expect(ktSet.size, 1);
      });
    } else {
      test("empty set asSet doesn't allow mutation", () {
        final ktSet = emptySet();
        expect(ktSet.isEmpty(), isTrue);
        final e =
            catchException<UnsupportedError>(() => ktSet.asSet().add("asdf"));
        expect(e.message, contains("unmodifiable"));
      });

      test("empty set set doesn't allow mutation", () {
        final ktSet = emptySet();
        expect(ktSet.isEmpty(), isTrue);
        final e =
            catchException<UnsupportedError>(() => ktSet.set.add("asdf"));
        expect(e.message, contains("unmodifiable"));
      });
    }
  });
}
