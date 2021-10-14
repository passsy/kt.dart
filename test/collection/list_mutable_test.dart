import "package:kt_dart/collection.dart";
import "package:test/test.dart";

void main() {
  group("KtMutableList", () {
    testList(<T>() => KtMutableList.empty(), mutableListOf, mutableListFrom);
  });

  group("KtMutableList.of constructor", () {
    test("creates correct size", () {
      final list = KtMutableList.of("1", "2", "3");
      expect(list.size, 3);
    });
    test("creates empty", () {
      final list = KtMutableList<String>.of();
      expect(list.isEmpty(), isTrue);
      expect(list.size, 0);
      expect(list, emptyList<String>());
    });
    test("allows null", () {
      final list = KtMutableList.of("1", null, "3");
      expect(list.size, 3);
      expect(list.dart, ["1", null, "3"]);
      expect(list, KtList.from(["1", null, "3"]));
    });
    test("only null is fine", () {
      // ignore: avoid_redundant_argument_values
      final list = KtMutableList<String?>.of(null);
      expect(list.size, 1);
      expect(list.dart, [null]);
      expect(list, KtList.from([null]));
    });
  });
}

void testList(
    KtMutableList<T> Function<T>() emptyList,
    KtMutableList<T> Function<T>(
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
        mutableListOf,
    KtMutableList<T> Function<T>([Iterable<T> iterable]) mutableListFrom,
    {bool ordered = true}) {
  group("basic methods", () {
    test("has no elements", () {
      final list = mutableListOf();
      expect(list.size, equals(0));
    });

    test("contains nothing", () {
      final list = mutableListOf<String?>("a", "b", "c");
      expect(list.contains("a"), isTrue);
      expect(list.contains("b"), isTrue);
      expect(list.contains("c"), isTrue);
      expect(list.contains(null), isFalse);
      expect(list.contains(""), isFalse);
      expect(list.contains(null), isFalse);
    });

    test("iterator with 1 element has 1 next", () {
      final list = mutableListOf("a");
      final iterator = list.iterator();
      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), equals("a"));

      expect(iterator.hasNext(), isFalse);
      expect(() => iterator.next(),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("is list", () {
      final list = mutableListOf("asdf");

      expect(list.isEmpty(), isFalse);
      expect(list.isEmpty(), isFalse);
    });

    test("get returns elements", () {
      final list = mutableListOf("a", "b", "c");

      expect(list.get(0), equals("a"));
      expect(list.get(1), equals("b"));
      expect(list.get(2), equals("c"));
      expect(() => list.get(3),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.get(-1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
    });

    test("[] returns elements", () {
      final list = mutableListOf("a", "b", "c");

      expect(list[0], equals("a"));
      expect(list[1], equals("b"));
      expect(list[2], equals("c"));
      expect(() => list[3],
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list[-1],
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
    });

    test("indexOf return element or -1", () {
      final list = mutableListOf<String?>("a", "b", "c");

      expect(list.indexOf(""), equals(-1));
      expect(list.indexOf("a"), equals(0));
      expect(list.indexOf("b"), equals(1));
      expect(list.indexOf("c"), equals(2));
      expect(list.indexOf("d"), equals(-1));
      expect(list.indexOf(null), equals(-1));
    });

    test("is equals to another list list", () {
      final list0 = mutableListOf("a", "b", "c");
      final list1 = mutableListOf("a", "b", "c");
      final list2 = mutableListOf("a", "c");

      expect(list0, equals(list1));
      expect(list0.hashCode, equals(list1.hashCode));

      expect(list0, isNot(equals(list2)));
      expect(list0.hashCode, isNot(equals(list2.hashCode)));
    });

    test("set", () {
      final list = mutableListOf(1, 2, 3, 4, 5);
      list.set(2, 10);
      expect(list, listOf(1, 2, 10, 4, 5));
      list.set(0, 4);
      expect(list, listOf(4, 2, 10, 4, 5));
      list.set(4, 1);
      expect(list, listOf(4, 2, 10, 4, 1));
    });

    test("set operator", () {
      final list = mutableListOf(1, 2, 3, 4, 5);
      list[2] = 10;
      expect(list, listOf(1, 2, 10, 4, 5));
      list[0] = 4;
      expect(list, listOf(4, 2, 10, 4, 5));
      list[4] = 1;
      expect(list, listOf(4, 2, 10, 4, 1));
    });

    test("sublist works ", () {
      final list = mutableListOf("a", "b", "c");
      final subList = list.subList(1, 3);
      expect(subList, equals(mutableListOf("b", "c")));
    });

    test("sublist throws for illegal ranges", () {
      final list = mutableListOf("a", "b", "c");

      expect(() => list.subList(0, 10),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.subList(6, 10),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.subList(-1, -1),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.subList(3, 1),
          throwsA(const TypeMatcher<ArgumentError>()));
      expect(() => list.subList(2, 10),
          throwsA(const TypeMatcher<IndexOutOfBoundsException>()));
    });

    test("add item appends item to end", () {
      final list = mutableListFrom<String>(["World"]);
      list.add("Hello");
      expect(list, listOf("World", "Hello"));
    });

    test("addAt to specific position (first)", () {
      final list = mutableListFrom<String>(["World"]);
      list.addAt(0, "Hello");
      expect(list, listOf("Hello", "World"));
    });

    test("addAt to specific position (last)", () {
      final list = mutableListFrom<String>(["World"]);
      list.addAt(1, "Hello");
      expect(list, listOf("World", "Hello"));
    });

    test("addAll add items at the end of the list", () {
      final list = mutableListOf("a");
      list.addAll(listOf("b", "c"));
      expect(list.size, equals(3));
      expect(list, equals(listOf("a", "b", "c")));
    });

    test("addAllAt 0 add items at the beginning of the list", () {
      final list = mutableListOf("a");
      list.addAllAt(0, listOf("b", "c"));
      expect(list.size, equals(3));
      expect(list, equals(listOf("b", "c", "a")));
    });

    test("equals although differnt types (subtypes)", () {
      expect(mutableListOf<int>(1, 2, 3), mutableListOf<num>(1, 2, 3));
      expect(mutableListOf<num>(1, 2, 3), mutableListOf<int>(1, 2, 3));
      expect(linkedSetOf<int>(1, 2, 3), linkedSetOf<num>(1, 2, 3));
      expect(linkedSetOf<num>(1, 2, 3), linkedSetOf<int>(1, 2, 3));
    });
  });

  group("removeFirst", () {
    test("remove first item when found", () {
      final list = mutableListOf("1", "2", "3");
      final result = list.removeFirst();
      expect(list, mutableListOf("2", "3"));
      expect(result, "1");
    });
    test("remove first item when length is 1", () {
      final list = mutableListOf("1");
      final result = list.removeFirst();
      expect(list, mutableListOf());
      expect(result, "1");
    });
    test("remove first item when null", () {
      final list = mutableListOf(null, null);
      final result = list.removeFirst();
      expect(list, mutableListOf(null));
      expect(result, null);
    });
    test("throw when list is empty", () {
      final list = mutableListOf();
      expect(() => list.removeFirst(), throwsA(isA<NoSuchElementException>()));
    });
  });

  group("removeLast", () {
    test("remove last item when found", () {
      final list = mutableListOf("1", "2", "3");
      final result = list.removeLast();
      expect(list, mutableListOf("1", "2"));
      expect(result, "3");
    });
    test("remove last item when length is 1", () {
      final list = mutableListOf("1");
      final result = list.removeLast();
      expect(list, mutableListOf());
      expect(result, "1");
    });
    test("remove last item when null", () {
      final list = mutableListOf(null, "2", null);
      final result = list.removeLast();
      expect(list, mutableListOf(null, "2"));
      expect(result, null);
    });
    test("throw when list is empty", () {
      final list = mutableListOf();
      expect(() => list.removeLast(), throwsA(isA<NoSuchElementException>()));
    });
  });
}
