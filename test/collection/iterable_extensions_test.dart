import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/iterable.dart';
import 'package:test/test.dart';

void main() {
  group('any', () {
    test("matches single", () {
      final iterable = _iterableOf(["abc", "bcd", "cde"]);
      expect(iterable.any((e) => e.contains("a")), isTrue);
    });
    test("matches all", () {
      final iterable = _iterableOf(["abc", "bcd", "cde"]);
      expect(iterable.any((e) => e.contains("c")), isTrue);
    });
    test("is false when none matches", () {
      final iterable = _iterableOf(["abc", "bcd", "cde"]);
      expect(iterable.any((e) => e.contains("x")), isFalse);
    });
  });

  group('associateWith', () {
    test("associateWith", () {
      final iterable = _iterableOf(["a", "b", "c"]);
      var result = iterable.associateWith((it) => it.toUpperCase());
      var expected = mapOf({"a": "A", "b": "B", "c": "C"});
      expect(result, equals(expected));
    });
    test("associateWith on empty map", () {
      final iterable = _emptyIterable<String>();
      var result = iterable.associateWith((it) => it.toUpperCase());
      expect(result, equals(emptyMap()));
    });
  });

  group("distinct", () {
    test("distinct elements", () {
      final iterable = _iterableOf(["a", "b", "c", "b"]);
      expect(iterable.distinct().toList(), equals(listOf(["a", "b", "c"])));
    });

    test("distinct by", () {
      final iterable = _iterableOf(["paul", "peter", "john", "lisa"]);
      expect(iterable.distinctBy((it) => it.length),
          equals(listOf(["paul", "peter"])));
    });
  });

  group("count", () {
    test("count elements", () {
      expect(_iterableOf([1, 2, 3, 4, 5]).count(), 5);
    });

    test("count even", () {
      expect(_iterableOf([1, 2, 3, 4, 5]).count((it) => it % 2 == 0), 2);
    });
  });

  group("drop", () {
    test("drop first value", () {
      final iterable = _iterableOf(["a", "b", "c"]);
      expect(iterable.drop(1), equals(listOf(["b", "c"])));
    });
    test("drop empty does nothing", () {
      final iterable = _emptyIterable<int>();
      expect(iterable.drop(1).toList(), equals(emptyList<int>()));
    });
    test("drop on iterable returns a iterable", () {
      final iterable = _emptyIterable<int>();
      expect(iterable.drop(1), TypeMatcher<KList<int>>());
    });
  });

  group("filter", () {
    test("filter", () {
      final iterable = _iterableOf(["paul", "peter", "john", "lisa"]);
      expect(iterable.filter((it) => it.contains("a")),
          equals(listOf(["paul", "lisa"])));
    });

    test("filterNot", () {
      final iterable = _iterableOf(["paul", "peter", "john", "lisa"]);
      expect(iterable.filterNot((it) => it.contains("a")),
          equals(listOf(["peter", "john"])));
    });

    test("filterNotNull", () {
      final iterable = _iterableOf(["paul", null, "john", "lisa"]);
      expect(
          iterable.filterNotNull(), equals(listOf(["paul", "john", "lisa"])));
    });

    test("filterIsInstance", () {
      final iterable = _iterableOf<Object>(["paul", null, "john", 1, "lisa"]);
      expect(iterable.filterIsInstance<String>(),
          equals(listOf(["paul", "john", "lisa"])));
    });
  });

  group("first", () {
    test("get first element", () {
      expect(setOf(["a", "b"]).first(), "a");
    });

    test("first throws for no elements", () {
      expect(() => _emptyIterable().first(),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("finds nothing throws", () {
      expect(() => setOf<String>(["a"]).first((it) => it == "b"),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });
  });

  group("flatMap", () {
    test("flatMap int to string", () {
      final iterable = _iterableOf([1, 2, 3]);
      expect(
          iterable.flatMap((it) => _iterableOf([it, it + 1, it + 2])).toList(),
          listOf([1, 2, 3, 2, 3, 4, 3, 4, 5]));
    });
  });

  group("groupBy", () {
    test("basic", () {
      final iterable = _iterableOf(["paul", "peter", "john", "lisa"]);
      expect(
          iterable.groupBy((it) => it.length),
          equals(mapOf({
            4: listOf(["paul", "john", "lisa"]),
            5: listOf(["peter"]),
          })));
    });

    test("valuetransform", () {
      final iterable = _iterableOf(["paul", "peter", "john", "lisa"]);
      expect(
          iterable.groupByTransform(
              (it) => it.length, (it) => it.toUpperCase()),
          equals(mapOf({
            4: listOf(["PAUL", "JOHN", "LISA"]),
            5: listOf(["PETER"]),
          })));
    });
  });

  group("intersect", () {
    test("remove one item", () {
      var a = _iterableOf(["paul", "john", "max", "lisa"]);
      var b = _iterableOf(["julie", "richard", "john", "lisa"]);
      final result = a.intersect(b);
      expect(result, setOf(["john", "lisa"]));
    });
  });

  group("map", () {
    test("map int to string", () {
      final iterable = _iterableOf([1, 2, 3]);
      expect(iterable.map((it) => it.toString()).toList(),
          listOf(["1", "2", "3"]));
    });
  });

  group("mapNotNull", () {
    test("mapNotNull int to string", () {
      final iterable = _iterableOf([1, null, 2, null, 3]);
      expect(iterable.mapNotNull((it) => it?.toString()).toList(),
          listOf(["1", "2", "3"]));
    });
  });

  group("max", () {
    test("gets max value", () {
      final iterable = _iterableOf([1, 3, 2]);
      expect(iterable.max(), 3);
    });
    test("empty iterable return null", () {
      final iterable = _emptyIterable<int>();
      expect(iterable.max(), null);
    });

    test("throws for non nums", () {
      expect(() => _iterableOf(["1", "2", "3"]).max(), throwsArgumentError);
    });
  });

  group("min", () {
    test("gets min value", () {
      final iterable = _iterableOf([1, 3, 2]);
      expect(iterable.min(), 1);
    });

    test("empty iterable return null", () {
      final iterable = _emptyIterable<int>();
      expect(iterable.min(), null);
    });

    test("throws for non nums", () {
      expect(() => _iterableOf(["1", "2", "3"]).min(), throwsArgumentError);
    });
  });

  group("minus", () {
    test("remove iterable", () {
      final result = _iterableOf(["paul", "john", "max", "lisa"])
          .minus(_iterableOf(["max", "john"]));
      expect(result, listOf(["paul", "lisa"]));
    });

    test("infix", () {
      final result =
          _iterableOf(["paul", "john", "max", "lisa"]) - _iterableOf(["max"]);
      expect(result.toList(), listOf(["paul", "john", "lisa"]));
    });

    test("remove one item", () {
      final result =
          _iterableOf(["paul", "john", "max", "lisa"]).minusElement("max");
      expect(result.toList(), listOf(["paul", "john", "lisa"]));
    });
  });

  group("plus", () {
    test("concat two iterables", () {
      final result = _iterableOf([1, 2, 3]).plus(_iterableOf([4, 5, 6]));
      expect(result.toList(), listOf([1, 2, 3, 4, 5, 6]));
    });

    test("infix", () {
      final result = _iterableOf([1, 2, 3]) + _iterableOf([4, 5, 6]);
      expect(result.toList(), listOf([1, 2, 3, 4, 5, 6]));
    });
  });

  group("reduce", () {
    test("reduce", () {
      final result =
          _iterableOf([1, 2, 3, 4]).reduce((int acc, it) => it + acc);
      expect(result, 10);
    });

    test("empty throws", () {
      expect(() => _emptyIterable<int>().reduce((int acc, it) => it + acc),
          throwsUnsupportedError);
    });
  });

  group("reversed", () {
    test("mutliple", () {
      final result = _iterableOf([1, 2, 3, 4]).reversed();
      expect(result.toList(), listOf([4, 3, 2, 1]));
    });

    test("empty", () {
      expect(_emptyIterable<int>().reversed().toList(), emptyList<int>());
    });

    test("one", () {
      expect(_iterableOf<int>([1]).reversed().toList(), listOf<int>([1]));
    });
  });

  group("sort", () {
    test("sort", () {
      final result = _iterableOf([4, 2, 3, 1]).sorted();
      expect(result.toList(), listOf([1, 2, 3, 4]));
    });

    test("sortedDescending", () {
      final result = _iterableOf([4, 2, 3, 1]).sortedDescending();
      expect(result.toList(), listOf([4, 3, 2, 1]));
    });

    var lastChar = (String it) {
      var last = _iterableOf(it.runes).last();
      return String.fromCharCode(last);
    };

    test("sortBy", () {
      final result =
          _iterableOf(["paul", "john", "max", "lisa"]).sortedBy(lastChar);
      expect(result, listOf(["lisa", "paul", "john", "max"]));
    });

    test("sortByDescending", () {
      final result = _iterableOf(["paul", "john", "max", "lisa"])
          .sortedByDescending(lastChar);
      expect(result, listOf(["max", "john", "paul", "lisa"]));
    });
  });

  group("subtract", () {
    test("remove one item", () {
      final result = _iterableOf(["paul", "john", "max", "lisa"])
          .subtract(_iterableOf(["max"]));
      expect(result, setOf(["paul", "john", "lisa"]));
    });
  });

  group("sum", () {
    test("sum of ints", () {
      expect(_iterableOf([1, 2, 3, 4, 5]).sum(), 15);
    });

    test("sum of doubles", () {
      var sum = _iterableOf([1.0, 2.1, 3.2]).sum();
      expect(sum, closeTo(6.3, 0.000000001));
    });

    test("sum of strings throws", () {
      expect(() => _iterableOf(["1", "2", "3"]).sum(), throwsArgumentError);
    });
  });

  group("sumBy", () {
    test("double", () {
      expect(_iterableOf([1, 2, 3]).sumBy((i) => i * 2), 12);
    });

    test("factor 1.5", () {
      expect(_iterableOf([1, 2, 3]).sumByDouble((i) => i * 1.5), 9.0);
    });
  });

  group("windowed", () {
    test("default step", () {
      expect(
          _iterableOf([1, 2, 3, 4, 5]).windowed(3),
          listOf([
            listOf([1, 2, 3]),
            listOf([2, 3, 4]),
            listOf([3, 4, 5]),
          ]));
    });

    test("larger step", () {
      expect(
          _iterableOf([1, 2, 3, 4, 5]).windowed(3, step: 2),
          listOf([
            listOf([1, 2, 3]),
            listOf([3, 4, 5]),
          ]));
    });

    test("step doesn't fit length", () {
      expect(
          _iterableOf([1, 2, 3, 4, 5, 6]).windowed(3, step: 2),
          listOf([
            listOf([1, 2, 3]),
            listOf([3, 4, 5]),
          ]));
    });

    test("window can be smaller than length", () {
      expect(_iterableOf([1]).windowed(3, step: 2), emptyList());
    });

    test("step doesn't fit length, partial", () {
      expect(
          _iterableOf([1, 2, 3, 4, 5, 6])
              .windowed(3, step: 2, partialWindows: true),
          listOf([
            listOf([1, 2, 3]),
            listOf([3, 4, 5]),
            listOf([5, 6]),
          ]));
    });
    test("partial doesn't crash on empty iterable", () {
      expect(_emptyIterable().windowed(3, step: 2, partialWindows: true),
          emptyList());
    });
    test("window can be smaller than length, emitting partial only", () {
      expect(
          _iterableOf([1]).windowed(3, step: 2, partialWindows: true),
          listOf([
            listOf([1]),
          ]));
    });
  });

  group("windowedTransform", () {
    test("default step", () {
      expect(_iterableOf([1, 2, 3, 4, 5]).windowedTransform(3, (l) => l.sum()),
          listOf([6, 9, 12]));
    });

    test("larger step", () {
      expect(
          _iterableOf([1, 2, 3, 4, 5])
              .windowedTransform(3, (l) => l.sum(), step: 2),
          listOf([6, 12]));
    });

    test("step doesn't fit length", () {
      expect(
          _iterableOf([1, 2, 3, 4, 5, 6])
              .windowedTransform(3, (l) => l.sum(), step: 2),
          listOf([6, 12]));
    });

    test("window can be smaller than length", () {
      expect(_iterableOf([1]).windowed(3, step: 2), emptyList());
    });

    test("step doesn't fit length, partial", () {
      expect(
          _iterableOf([1, 2, 3, 4, 5, 6]).windowedTransform(3, (l) => l.sum(),
              step: 2, partialWindows: true),
          listOf([6, 12, 11]));
    });
    test("partial doesn't crash on empty iterable", () {
      expect(
          _emptyIterable().windowedTransform(3, (l) => l.sum(),
              step: 2, partialWindows: true),
          emptyList());
    });
    test("window can be smaller than length, emitting partial only", () {
      expect(
          _iterableOf([1]).windowedTransform(3, (l) => l.sum(),
              step: 2, partialWindows: true),
          listOf([1]));
    });
  });

  group("zip", () {
    test("to pair", () {
      final result = _iterableOf([1, 2, 3, 4, 5]).zip(_iterableOf(["a", "b"]));
      expect(result, listOf([KPair(1, "a"), KPair(2, "b")]));
    });
    test("transform", () {
      final result = _iterableOf([1, 2, 3, 4, 5])
          .zipTransform(_iterableOf(["a", "b"]), (a, b) => "$a$b");
      expect(result, listOf(["1a", "2b"]));
    });

    test("with next", () {
      final result =
          _iterableOf([1, 2, 3, 4, 5]).zipWithNextTransform((a, b) => a + b);
      expect(result, listOf([3, 5, 7, 9]));
    });
  });
}

KIterable<T> _emptyIterable<T>() => EmptyIterable<T>();

KIterable<T> _iterableOf<T>(Iterable<T> iterable) => DartIterable(iterable);
