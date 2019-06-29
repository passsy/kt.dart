import "package:kt_dart/collection.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("emptyList", () {
    testEmptyList(<T>() => emptyList<T>());
  });
  group("listOf", () {
    testEmptyList(<T>() => listOf<T>());
  });
  group("listFrom", () {
    testEmptyList(<T>() => listFrom<T>());
  });
  group("KtList.empty", () {
    testEmptyList(<T>() => KtList<T>.empty());
  });
  group("KtList.of", () {
    testEmptyList(<T>() => KtList<T>.of());
  });
  group("KtList.of", () {
    testEmptyList(<T>() => KtList<T>.from());
  });
  group("mutableList", () {
    testEmptyList(<T>() => emptyList<T>());
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
}

void testEmptyList(KtList<T> Function<T>() emptyList) {
  group("empty list", () {
    test("has no elements", () {
      final empty = emptyList<String>();
      expect(empty.size, equals(0));
    });

    test("contains nothing", () {
      expect(emptyList<String>().contains("asdf"), isFalse);
      expect(emptyList<int>().contains(null), isFalse);
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

    test("throws when accessing an element", () {
      final empty = emptyList();

      expect(() => empty.get(0),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.get(1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => empty.get(-1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(
          () => empty.get(null), throwsA(const TypeMatcher<ArgumentError>()));
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

    test("sublist doesn't allow null as fromIndex", () {
      final e =
          catchException<ArgumentError>(() => emptyList().subList(null, 10));
      expect(e.message, allOf(contains("null"), contains("fromIndex")));
    });

    test("sublist doesn't allow null as toIndex", () {
      final e =
          catchException<ArgumentError>(() => emptyList().subList(0, null));
      expect(e.message, allOf(contains("null"), contains("toIndex")));
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

    test("listIterator requires index", () {
      final ArgumentError e =
          catchException(() => emptyList().listIterator(null));
      expect(e.message, contains("index"));
      expect(e.message, contains("null"));
    });

    test("[] get operator", () {
      final list = emptyList();

      final e0 = catchException<IndexOutOfBoundsException>(() => list[0]);
      expect(e0.message, contains("doesn't contain element at index: 0"));
      final e1 = catchException<IndexOutOfBoundsException>(() => list[-1]);
      expect(e1.message, contains("doesn't contain element at index: -1"));
      final e2 = catchException<IndexOutOfBoundsException>(() => list[3]);
      expect(e2.message, contains("doesn't contain element at index: 3"));

      final e3 = catchException<ArgumentError>(() => list[null]);
      expect(e3.message, allOf(contains("null"), contains("index")));
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
  });
}
