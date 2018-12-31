import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group('basic methods', () {
    test("has no elements", () {
      final list = listOf();
      expect(list.size, equals(0));
    });

    test("contains nothing", () {
      final list = listOf("a", "b", "c");
      expect(list.contains("a"), isTrue);
      expect(list.contains("b"), isTrue);
      expect(list.contains("c"), isTrue);
      expect(list.contains(null), isFalse);
      expect(list.contains(""), isFalse);
      expect(list.contains(null), isFalse);
    });

    test("iterator with 1 element has 1 next", () {
      final list = listOf("a");
      final iterator = list.iterator();
      expect(iterator.hasNext(), isTrue);
      expect(iterator.next(), equals("a"));

      expect(iterator.hasNext(), isFalse);
      expect(() => iterator.next(),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("is list", () {
      final list = listOf("asdf");

      expect(list.isEmpty(), isFalse);
      expect(list.isEmpty(), isFalse);
    });

    test("get returns elements", () {
      final list = listOf("a", "b", "c");

      expect(list.get(0), equals("a"));
      expect(list.get(1), equals("b"));
      expect(list.get(2), equals("c"));
      expect(
          () => list.get(3), throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.get(-1),
          throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list.get(null), throwsA(TypeMatcher<ArgumentError>()));
    });

    test("[] returns elements", () {
      final list = listOf("a", "b", "c");

      expect(list[0], equals("a"));
      expect(list[1], equals("b"));
      expect(list[2], equals("c"));
      expect(() => list[3], throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list[-1], throwsA(TypeMatcher<IndexOutOfBoundsException>()));
      expect(() => list[null], throwsA(TypeMatcher<ArgumentError>()));
    });

    test("indexOf returns first element or -1", () {
      final list = listOf("a", "b", "c", "a");

      expect(list.indexOf(""), equals(-1));
      expect(list.indexOf("a"), equals(0));
      expect(list.indexOf("b"), equals(1));
      expect(list.indexOf("c"), equals(2));
      expect(list.indexOf("d"), equals(-1));
      expect(list.indexOf(null), equals(-1));
    });

    test("lastIndexOf returns last element or -1", () {
      final list = listOf("a", "b", "c", "a");

      expect(list.lastIndexOf(""), equals(-1));
      expect(list.lastIndexOf("a"), equals(3));
      expect(list.lastIndexOf("b"), equals(1));
      expect(list.lastIndexOf("c"), equals(2));
      expect(list.lastIndexOf("d"), equals(-1));
      expect(list.lastIndexOf(null), equals(-1));
    });

    test("is equals to another list list", () {
      final list0 = listOf("a", "b", "c");
      final list1 = listOf("a", "b", "c");
      final list2 = listOf("a", "c");

      expect(list0, equals(list1));
      expect(list0.hashCode, equals(list1.hashCode));

      expect(list0, isNot(equals(list2)));
      expect(list0.hashCode, isNot(equals(list2.hashCode)));
    });

    group("reduceRight", () {
      test("reduce", () {
        final result =
            listOf(1, 2, 3, 4).reduceRight((it, int acc) => it + acc);
        expect(result, 10);
      });

      test("empty throws", () {
        expect(() => emptyList<int>().reduceRight((it, int acc) => it + acc),
            throwsUnsupportedError);
      });

      test("reduceRight doesn't allow null as operation", () {
        final list = emptyList<String>();
        var e = catchException<ArgumentError>(() => list.reduceRight(null));
        expect(e.message, allOf(contains("null"), contains("operation")));
      });
    });

    group("reduceRightIndexed", () {
      test("reduceRightIndexed", () {
        var i = 2;
        final result =
            listOf(1, 2, 3, 4).reduceRightIndexed((index, it, int acc) {
          expect(index, i);
          i--;
          return it + acc;
        });
        expect(result, 10);
      });

      test("empty throws", () {
        expect(
            () => emptyList<int>()
                .reduceRightIndexed((index, it, int acc) => it + acc),
            throwsUnsupportedError);
      });

      test("reduceRightIndexed doesn't allow null as operation", () {
        final list = emptyList<String>();
        var e =
            catchException<ArgumentError>(() => list.reduceRightIndexed(null));
        expect(e.message, allOf(contains("null"), contains("operation")));
      });
    });

    test("sublist works ", () {
      final list = listOf("a", "b", "c");
      final subList = list.subList(1, 3);
      expect(subList, equals(listOf("b", "c")));
    });

    test("sublist throws for illegal ranges", () {
      final list = listOf("a", "b", "c");

      expect(
          catchException<IndexOutOfBoundsException>(() => list.subList(0, 10))
              .message,
          allOf(
            contains("0"),
            contains("10"),
            contains("3"),
          ));
      expect(
          catchException<IndexOutOfBoundsException>(() => list.subList(6, 10))
              .message,
          allOf(
            contains("6"),
            contains("10"),
            contains("3"),
          ));
      expect(
          catchException<IndexOutOfBoundsException>(() => list.subList(-1, -1))
              .message,
          allOf(
            contains("-1"),
            contains("3"),
          ));
      expect(
          catchException<ArgumentError>(() => list.subList(3, 1)).message,
          allOf(
            contains("3"),
            contains("1"),
          ));
      expect(
          catchException<IndexOutOfBoundsException>(() => list.subList(2, 10))
              .message,
          allOf(
            contains("2"),
            contains("10"),
            contains("3"),
          ));
      expect(catchException<ArgumentError>(() => list.subList(null, 1)).message,
          contains("fromIndex"));
      expect(catchException<ArgumentError>(() => list.subList(1, null)).message,
          contains("toIndex"));
    });

    test("access dart list", () {
      List<String> list = listFrom<String>(["a", "b", "c"]).list;
      expect(list.length, 3);
      expect(list, equals(["a", "b", "c"]));
    });

    test("listIterator requires index", () {
      ArgumentError e =
          catchException(() => listOf("a", "b", "c").listIterator(null));
      expect(e.message, contains("index"));
      expect(e.message, contains("null"));
    });

    test("equals although differnt types (subtypes)", () {
      expect(listOf<int>([1, 2, 3]), listOf<num>([1, 2, 3]));
      expect(listOf<num>([1, 2, 3]), listOf<int>([1, 2, 3]));
    });
  });
}
