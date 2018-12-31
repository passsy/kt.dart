import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group("clear", () {
    test("clear list", () {
      final list = mutableListOf("a", "b", "c");
      expect(list.size, 3);
      list.clear();
      expect(list.size, 0);
    });
    test("clear empty list", () {
      final list = mutableListOf();
      expect(list.size, 0);
      list.clear();
      expect(list.size, 0);
    });
  });

  group('fill', () {
    test("replace all elements", () {
      final list = mutableListOf("a", "b", "c");
      list.fill("x");
      expect(list, listOf("x", "x", "x"));
    });

    test("on empty list", () {
      final list = mutableListFrom<String>([]);
      list.fill("x");
      expect(list, emptyList());
    });
  });

  group("removeAt", () {
    test("index can't be null", () {
      final e =
          catchException<ArgumentError>(() => mutableListOf().removeAt(null));
      expect(e.message, allOf(contains("null"), contains("index")));
    });

    test("removes item at index", () {
      final list = mutableListOf("a", "b", "c");
      list.removeAt(1);
      expect(list, listOf("a", "c"));
    });

    test("removeAt throw for indexes greater size", () {
      final list = mutableListOf("a", "b", "c");
      final e =
          catchException<IndexOutOfBoundsException>(() => list.removeAt(-1));
      expect(e.message, allOf(contains("3"), contains("")));
    });

    test("removeAt throw for indexes below 0", () {
      final list = mutableListOf("a", "b", "c");
      final e =
          catchException<IndexOutOfBoundsException>(() => list.removeAt(-1));
      expect(e.message, allOf(contains("-1"), contains("")));
    });
  });

  group("sorted", () {
    var lastChar = (String it) {
      var last = it.runes.last;
      return String.fromCharCode(last);
    };

    test("sortBy", () {
      final result = mutableListOf("paul", "john", "max", "lisa")
        ..sortBy(lastChar);
      expect(result, listOf("lisa", "paul", "john", "max"));
    });

    test("sortBy doesn't allow null as argument", () {
      num Function(dynamic) selector = null;
      final e = catchException<ArgumentError>(
          () => mutableListOf<String>()..sortBy(selector));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });

    test("sortByDescending", () {
      final result = mutableListOf("paul", "john", "max", "lisa")
        ..sortByDescending(lastChar);
      expect(result, listOf("max", "john", "paul", "lisa"));
    });

    test("sortByDescending doesn't allow null as argument", () {
      num Function(dynamic) selector = null;
      final e = catchException<ArgumentError>(
          () => mutableListOf<String>()..sortByDescending(selector));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });

    test("sortWith doesn't allow null as argument", () {
      final e = catchException<ArgumentError>(
          () => mutableListOf<String>()..sortWith(null));
      expect(e.message, allOf(contains("null"), contains("comparator")));
    });
  });
}
