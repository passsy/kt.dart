import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("EmptyList", () {
    group("emptyList", () {
      testEmptyList(<T>() => emptyList<T>(), mutable: false);
    });
    group("listOf", () {
      testEmptyList(<T>() => listOf<T>(), mutable: false);
    });
    group("listFrom", () {
      testEmptyList(<T>() => listFrom<T>(), mutable: false);
    });
    group("KtList.empty", () {
      testEmptyList(<T>() => KtList<T>.empty(), mutable: false);
    });
    group("KtList.of", () {
      testEmptyList(<T>() => KtList<T>.of(), mutable: false);
    });
    group("KtList.from", () {
      testEmptyList(<T>() => KtList<T>.from(), mutable: false);
    });
    group("mutableListOf", () {
      testEmptyList(<T>() => mutableListOf<T>());
    });
    group("mutableListFrom", () {
      testEmptyList(<T>() => mutableListFrom<T>());
    });
    group("KtMutableList.empty", () {
      testEmptyList(<T>() => KtMutableList<T>.empty());
    });
    group("KtMutableList.of", () {
      testEmptyList(<T>() => KtMutableList<T>.of());
    });
    group("KtMutableList.from", () {
      testEmptyList(<T>() => KtMutableList<T>.from());
    });
  });
}

void testEmptyList(KtList<T> Function<T>() emptyList, {bool mutable = true}) {
  group("empty list", () {
    test("has no elements", () {
      final empty = emptyList<String>();
      expect(empty.size, equals(0));
    });

    test("contains nothing", () {
      expect(emptyList<String>().contains("asdf"), isFalse);
      expect(emptyList<int?>().contains(null), isFalse);
      expect(emptyList<int>().contains(0), isFalse);
      expect(emptyList<List>().contains([]), isFalse);
    });

    test("iterator has no next", () {
      final empty = emptyList();

      expect(empty.iterator().hasNext(), isFalse);
      expect(() => empty.iterator().next(),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("is empty", () {
      final empty = emptyList();

      expect(empty.isEmpty(), isTrue);
    });

    test("iterator have correct type", () {
      final list = emptyList<Map<int, String>>();
      expect(list.iterator().runtimeType.toString(),
          contains("Map<int, String>>"));
    });

    test("throws when accessing an element", () {
      final empty = emptyList();

      expect(() => empty.get(0),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.get(1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.get(-1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
    });

    test("indexOf always returns -1", () {
      final empty = emptyList();

      expect(empty.indexOf(""), equals(-1));
      expect(empty.indexOf([]), equals(-1));
      expect(empty.indexOf(0), equals(-1));
      expect(empty.indexOf(null), equals(-1));
    });

    test("lastIndexOf always returns -1", () {
      final empty = emptyList();

      expect(empty.lastIndexOf(""), equals(-1));
      expect(empty.lastIndexOf([]), equals(-1));
      expect(empty.lastIndexOf(0), equals(-1));
      expect(empty.lastIndexOf(null), equals(-1));
    });

    test("is equals to another empty list", () {
      final empty0 = emptyList();
      final empty1 = emptyList();

      expect(empty0, equals(empty1));
      expect(empty0.hashCode, equals(empty1.hashCode));
    });

    test("empty lists of different type are equal", () {
      final empty0 = emptyList<int>();
      final empty1 = emptyList<String>();

      expect(empty0, equals(empty1));
      expect(empty0.hashCode, equals(empty1.hashCode));
    });

    test("is equals to another list without items", () {
      final empty0 = emptyList<String>();
      final empty1 = mutableListOf();

      expect(empty0.hashCode, equals(empty1.hashCode));
      expect(empty0, equals(empty1));
    });

    test("sublist works for index 0 to 0", () {
      final empty = emptyList<Object>();
      final subList = empty.subList(0, 0);
      expect(subList.size, equals(0));
      expect(subList, equals(empty));
    });

    test("sublist throws for all other ranges", () {
      final empty = emptyList<int>();

      expect(() => empty.subList(0, 1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.subList(1, 1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.subList(-1, -1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.subList(2, 10),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
    });

    test("access dart list", () {
      final List<String> list = emptyList<String>().asList();
      expect(list.length, 0);
    });

    test("[] get operator", () {
      final list = emptyList();

      final e0 = catchException<IndexOutOfBoundsException>(() => list[0]);
      expect(e0.message, contains("doesn't contain element at index: 0"));
      final e1 = catchException<IndexOutOfBoundsException>(() => list[-1]);
      expect(e1.message, contains("doesn't contain element at index: -1"));
      final e2 = catchException<IndexOutOfBoundsException>(() => list[3]);
      expect(e2.message, contains("doesn't contain element at index: 3"));
    });

    test("toString prints empty list", () {
      expect(emptyList().toString(), "[]");
    });

    test("listIterator doesn't iterate", () {
      final i = emptyList().listIterator();
      expect(i.hasNext(), false);
      expect(i.hasPrevious(), false);
      expect(i.nextIndex(), 0);
      expect(i.previousIndex(), -1);
      expect(() => i.previous(),
          throwsA(const TypeMatcher<NoSuchElementException>()));
      expect(
          () => i.next(), throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("deprecated list property returns an empty list", () {
      // ignore: deprecated_member_use_from_same_package
      final dartList = emptyList<int>().list;
      expect(dartList.length, 0);
    });

    if (!mutable) {
      test("deprecated list property returns an unmodifiable list", () {
        // ignore: deprecated_member_use_from_same_package
        final dartList = emptyList<int>().list;
        final e = catchException<UnsupportedError>(() => dartList.add(1));
        expect(e.message, contains("unmodifiable"));
      });
    } else {
      test("deprecated list property returns an modifiable list", () {
        final original = emptyList<int>();
        // ignore: deprecated_member_use_from_same_package
        final dartList = original.list;
        dartList.add(1);
        expect(original, listOf(1));
        expect(dartList, [1]);
      });
    }
  });
}
