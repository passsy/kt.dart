import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group('EmptySet', () {
    group('emptySet', () {
      testEmptySet(<T>() => emptySet<T>());
    });
    group('KtSet.empty', () {
      testEmptySet(<T>() => KtSet<T>.empty());
    });
    group('KtSet.of', () {
      testEmptySet(<T>() => KtSet<T>.of());
    });
    group('KtSet.from', () {
      testEmptySet(<T>() => KtSet<T>.from());
    });
    group('mutableSetFrom', () {
      testEmptySet(<T>() => mutableSetFrom<T>(), mutable: true);
    });
    group('mutableSetOf', () {
      testEmptySet(<T>() => mutableSetOf<T>(), mutable: true);
    });
    group('KtMutableSet.of', () {
      testEmptySet(<T>() => KtMutableSet<T>.of(), mutable: true);
    });
    group('KtMutableSet.from', () {
      testEmptySet(<T>() => KtMutableSet<T>.from(), mutable: true);
    });
    group('KtHashSet.from', () {
      testEmptySet(<T>() => KtHashSet<T>.from(), mutable: true);
    });
    group('KtHashSet.of', () {
      testEmptySet(<T>() => KtHashSet<T>.of(), mutable: true);
    });
    group('KtLinkedSet.from', () {
      testEmptySet(<T>() => KtLinkedSet<T>.from(), mutable: true);
    });
    group('KtLinkedSet.of', () {
      testEmptySet(<T>() => KtLinkedSet<T>.of(), mutable: true);
    });
  });
}

void testEmptySet(KtSet<T> Function<T>() emptySet, {bool mutable = false}) {
  test('empty iterator', () {
    final iterator = emptySet().iterator();
    expect(iterator.hasNext(), isFalse);
    expect(() => iterator.next(),
        throwsA(const TypeMatcher<NoSuchElementException>()));
  });

  test('contains nothing', () {
    final set = emptySet();
    expect(set.contains('a'), isFalse);
    expect(set.contains('b'), isFalse);
    expect(set.contains('c'), isFalse);
    expect(set.contains(null), isFalse);
    expect(set.contains(''), isFalse);
  });

  test('iterator have correct type', () {
    final set = emptySet<Map<int, String>>();
    expect(
        set.iterator().runtimeType.toString(), contains('Map<int, String>>'));
  });

  test('is empty', () {
    expect(emptySet().isEmpty(), isTrue);
  });
  test('equals although differnt types (subtypes)', () {
    expect(emptySet<int>(), emptySet<num>());
    expect(emptySet<num>(), emptySet<int>());
  });

  if (mutable) {
    test('dart property allows mutation', () {
      final ktSet = emptySet();
      expect(ktSet.isEmpty(), isTrue);
      final dartSet = ktSet.dart;
      dartSet.add('asdf');
      expect(dartSet.length, 1);
      expect(ktSet.size, 1);
    });

    test('empty set asSet allows mutation', () {
      final ktSet = emptySet();
      expect(ktSet.isEmpty(), isTrue);
      final dartSet = ktSet.asSet();
      dartSet.add('asdf');
      expect(dartSet.length, 1);
      expect(ktSet.size, 1);
    });

    test('empty set set allows mutation', () {
      final ktSet = emptySet();
      expect(ktSet.isEmpty(), isTrue);
      // ignore: deprecated_member_use_from_same_package
      final dartSet = ktSet.set;
      dartSet.add('asdf');
      expect(dartSet.length, 1);
      expect(ktSet.size, 1);
    });
  } else {
    test("dart property doesn't allow mutation", () {
      final ktSet = emptySet();
      expect(ktSet.isEmpty(), isTrue);
      final e = catchException<UnsupportedError>(() => ktSet.dart.add('asdf'));
      expect(e.message, contains('unmodifiable'));
    });

    test("empty set asSet doesn't allow mutation", () {
      final ktSet = emptySet();
      expect(ktSet.isEmpty(), isTrue);
      final e =
          catchException<UnsupportedError>(() => ktSet.asSet().add('asdf'));
      expect(e.message, contains('unmodifiable'));
    });

    test("empty set set doesn't allow mutation", () {
      final ktSet = emptySet();
      expect(ktSet.isEmpty(), isTrue);
      final e =
          // ignore: deprecated_member_use_from_same_package
          catchException<UnsupportedError>(() => ktSet.set.add('asdf'));
      expect(e.message, contains('unmodifiable'));
    });
  }
}
