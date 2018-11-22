import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('any', () {
    test("matches single", () {
      final list = listOf(["abc", "bcd", "cde"]);
      expect(list.any((e) => e.contains("a")), isTrue);
    });
    test("matches all", () {
      final list = listOf(["abc", "bcd", "cde"]);
      expect(list.any((e) => e.contains("c")), isTrue);
    });
    test("is false when none matches", () {
      final list = listOf(["abc", "bcd", "cde"]);
      expect(list.any((e) => e.contains("x")), isFalse);
    });
  });

  group('associateWith', () {
    test("associateWith", () {
      final list = listOf(["a", "b", "c"]);
      var result = list.associateWith((it) => it.toUpperCase());
      var expected = mapOf({"a": "A", "b": "B", "c": "C"});
      expect(result, equals(expected));
    });
    test("associateWith on empty map", () {
      final list = emptyList<String>();
      var result = list.associateWith((it) => it.toUpperCase());
      expect(result, equals(emptyMap()));
    });
  });

  group("distinct", () {
    test("distinct elements", () {
      final list = listOf(["a", "b", "c", "b"]);
      expect(list.distinct(), equals(listOf(["a", "b", "c"])));
    });

    test("distinct by", () {
      final list = listOf(["paul", "peter", "john", "lisa"]);
      expect(list.distinctBy((it) => it.length), equals(listOf(["paul", "peter"])));
    });
  });

  group("drop", () {
    test("drop first value", () {
      final list = listOf(["a", "b", "c"]);
      expect(list.drop(1), equals(listOf(["b", "c"])));
    });
    // TODO drop on empty
  });

  group("filter", () {
    test("filter", () {
      final list = listOf(["paul", "peter", "john", "lisa"]);
      expect(list.filter((it) => it.contains("a")), equals(listOf(["paul", "lisa"])));
    });

    test("filterNot", () {
      final list = listOf(["paul", "peter", "john", "lisa"]);
      expect(list.filterNot((it) => it.contains("a")), equals(listOf(["peter", "john"])));
    });

    test("filterNotNull", () {
      final list = listOf(["paul", null, "john", "lisa"]);
      expect(list.filterNotNull(), equals(listOf(["paul", "john", "lisa"])));
    });

    test("filterIsInstance", () {
      final list = listOf<Object>(["paul", null, "john", 1, "lisa"]);
      expect(list.filterIsInstance<String>(), equals(listOf(["paul", "john", "lisa"])));
    });
  });

  group("groupBy", () {
    test("basic", () {
      final list = listOf(["paul", "peter", "john", "lisa"]);
      expect(
          list.groupBy((it) => it.length),
          equals(mapOf({
            4: listOf(["paul", "john", "lisa"]),
            5: listOf(["peter"]),
          })));
    });

    test("valuetransform", () {
      final list = listOf(["paul", "peter", "john", "lisa"]);
      expect(
          list.groupByTransform((it) => it.length, (it) => it.toUpperCase()),
          equals(mapOf({
            4: listOf(["PAUL", "JOHN", "LISA"]),
            5: listOf(["PETER"]),
          })));
    });
  });

  group("drop", () {
    test("drop first value", () {
      final list = listOf(["a", "b", "c"]);
      expect(list.drop(1), equals(listOf(["b", "c"])));
    });
    // TODO drop on empty
  });

  group("max", () {
    test("gets max value", () {
      final list = listOf([1, 3, 2]);
      expect(list.max(), 3);
    });
    test("empty list return null", () {
      final list = emptyList<int>();
      expect(list.max(), null);
    });

    test("throws for non nums", () {
      expect(() => listOf(["1", "2", "3"]).max(), throwsArgumentError);
    });
  });

  group("min", () {
    test("gets min value", () {
      final list = listOf([1, 3, 2]);
      expect(list.min(), 1);
    });
    test("empty list return null", () {
      final list = emptyList<int>();
      expect(list.min(), null);
    });

    test("throws for non nums", () {
      expect(() => listOf(["1", "2", "3"]).min(), throwsArgumentError);
    });
  });

  group("sum", () {
    test("sum of ints", () {
      expect(listOf([1, 2, 3, 4, 5]).sum(), 15);
    });

    test("sum of doubles", () {
      var sum = listOf([1.0, 2.1, 3.2]).sum();
      expect(sum, closeTo(6.3, 0.000000001));
    });

    test("sum of strings throws", () {
      expect(() => listOf(["1", "2", "3"]).sum(), throwsArgumentError);
    });
  });

  group("sumBy", () {
    test("double", () {
      expect(listOf([1, 2, 3]).sumBy((i) => i * 2), 12);
    });

    test("factor 1.5", () {
      expect(listOf([1, 2, 3]).sumByDouble((i) => i * 1.5), 9.0);
    });
  });

  group("windowed", () {
    test("default step", () {
      expect(
          listOf([1, 2, 3, 4, 5]).windowed(3),
          listOf([
            listOf([1, 2, 3]),
            listOf([2, 3, 4]),
            listOf([3, 4, 5]),
          ]));
    });

    test("larger step", () {
      expect(
          listOf([1, 2, 3, 4, 5]).windowed(3, step: 2),
          listOf([
            listOf([1, 2, 3]),
            listOf([3, 4, 5]),
          ]));
    });

    test("step doesn't fit length", () {
      expect(
          listOf([1, 2, 3, 4, 5, 6]).windowed(3, step: 2),
          listOf([
            listOf([1, 2, 3]),
            listOf([3, 4, 5]),
          ]));
    });

    test("window can be smaller than length", () {
      expect(listOf([1]).windowed(3, step: 2), emptyList());
    });

    test("step doesn't fit length, partial", () {
      expect(
          listOf([1, 2, 3, 4, 5, 6]).windowed(3, step: 2, partialWindows: true),
          listOf([
            listOf([1, 2, 3]),
            listOf([3, 4, 5]),
            listOf([5, 6]),
          ]));
    });
    test("partial doesn't crash on empty list", () {
      expect(emptyList().windowed(3, step: 2, partialWindows: true), emptyList());
    });
    test("window can be smaller than length, emitting partial only", () {
      expect(
          listOf([1]).windowed(3, step: 2, partialWindows: true),
          listOf([
            listOf([1]),
          ]));
    });
  });

  group("windowedTransform", () {
    test("default step", () {
      expect(listOf([1, 2, 3, 4, 5]).windowedTransform(3, (l) => l.sum()), listOf([6, 9, 12]));
    });

    test("larger step", () {
      expect(listOf([1, 2, 3, 4, 5]).windowedTransform(3, (l) => l.sum(), step: 2), listOf([6, 12]));
    });

    test("step doesn't fit length", () {
      expect(listOf([1, 2, 3, 4, 5, 6]).windowedTransform(3, (l) => l.sum(), step: 2), listOf([6, 12]));
    });

    test("window can be smaller than length", () {
      expect(listOf([1]).windowed(3, step: 2), emptyList());
    });

    test("step doesn't fit length, partial", () {
      expect(listOf([1, 2, 3, 4, 5, 6]).windowedTransform(3, (l) => l.sum(), step: 2, partialWindows: true),
          listOf([6, 12, 11]));
    });
    test("partial doesn't crash on empty list", () {
      expect(emptyList().windowedTransform(3, (l) => l.sum(), step: 2, partialWindows: true), emptyList());
    });
    test("window can be smaller than length, emitting partial only", () {
      expect(listOf([1]).windowedTransform(3, (l) => l.sum(), step: 2, partialWindows: true), listOf([1]));
    });
  });
}
