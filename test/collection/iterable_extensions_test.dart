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

  group("count", () {
    test("count elements", () {
      expect(listOf([1, 2, 3, 4, 5]).count(), 5);
    });

    test("count even", () {
      expect(listOf([1, 2, 3, 4, 5]).count((it) => it % 2 == 0), 2);
    });
  });

  group("drop", () {
    test("drop first value", () {
      final list = listOf(["a", "b", "c"]);
      expect(list.drop(1), equals(listOf(["b", "c"])));
    });
    test("drop empty does nothing", () {
      final list = emptyList<int>();
      expect(list.drop(1), equals(emptyList<int>()));
    });
    test("drop on list returns a list", () {
      final list = emptyList<int>();
      expect(list.drop(1), TypeMatcher<KList<int>>());
    });
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

  group("intersect", () {
    test("remove one item", () {
      var a = listOf(["paul", "john", "max", "lisa"]);
      var b = listOf(["julie", "richard", "john", "lisa"]);
      final result = a.intersect(b);
      expect(result, setOf(["john", "lisa"]));
    });
  });

  group("map", () {
    test("map int to string", () {
      final list = listOf([1, 2, 3]);
      expect(list.map((it) => it.toString()), listOf(["1", "2", "3"]));
    });
  });

  group("mapNotNull", () {
    test("mapNotNull int to string", () {
      final list = listOf([1, null, 2, null, 3]);
      expect(list.mapNotNull((it) => it?.toString()), listOf(["1", "2", "3"]));
    });
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

  group("plus", () {
    test("concat two lists", () {
      final result = listOf([1, 2, 3]).plus(listOf([4, 5, 6]));
      expect(result, listOf([1, 2, 3, 4, 5, 6]));
    });

    test("infix", () {
      final result = listOf([1, 2, 3]) + listOf([4, 5, 6]);
      expect(result, listOf([1, 2, 3, 4, 5, 6]));
    });
  });

  group("reduce", () {
    test("reduce", () {
      final result = listOf([1, 2, 3, 4]).reduce((int acc, it) => it + acc);
      expect(result, 10);
    });

    test("empty throws", () {
      expect(() => emptyList<int>().reduce((int acc, it) => it + acc), throwsUnsupportedError);
    });
  });

  group("reversed", () {
    test("mutliple", () {
      final result = listOf([1, 2, 3, 4]).reversed();
      expect(result, listOf([4, 3, 2, 1]));
    });

    test("empty", () {
      expect(emptyList<int>().reversed(), emptyList<int>());
    });

    test("one", () {
      expect(listOf<int>([1]).reversed(), listOf<int>([1]));
    });
  });

  group("sort", () {
    test("sort", () {
      final result = listOf([4, 2, 3, 1]).sorted();
      expect(result, listOf([1, 2, 3, 4]));
    });

    test("sortedDescending", () {
      final result = listOf([4, 2, 3, 1]).sortedDescending();
      expect(result, listOf([4, 3, 2, 1]));
    });

    var lastChar = (String it) {
      var last = listOf(it.runes).last();
      return String.fromCharCode(last);
    };

    test("sortBy", () {
      final result = listOf(["paul", "john", "max", "lisa"]).sortedBy(lastChar);
      expect(result, listOf(["lisa", "paul", "john", "max"]));
    });

    test("sortByDescending", () {
      final result = listOf(["paul", "john", "max", "lisa"]).sortedByDescending(lastChar);
      expect(result, listOf(["max", "john", "paul", "lisa"]));
    });
  });

  group("subtract", () {
    test("remove one item", () {
      final result = listOf(["paul", "john", "max", "lisa"]).subtract(listOf(["max"]));
      expect(result, setOf(["paul", "john", "lisa"]));
    });
    test("infix", () {
      final result = listOf(["paul", "john", "max", "lisa"]) - listOf(["max"]);
      expect(result, setOf(["paul", "john", "lisa"]));
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

  group("zip", () {
    test("to pair", () {
      final result = listOf([1, 2, 3, 4, 5]).zip(listOf(["a", "b"]));
      expect(result, listOf([KPair(1, "a"), KPair(2, "b")]));
    });
    test("transform", () {
      final result = listOf([1, 2, 3, 4, 5]).zipTransform(listOf(["a", "b"]), (a, b) => "$a$b");
      expect(result, listOf(["1a", "2b"]));
    });

    test("with next", () {
      final result = listOf([1, 2, 3, 4, 5]).zipWithNextTransform((a, b) => a + b);
      expect(result, listOf([3, 5, 7, 9]));
    });
  });
}
