import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('fill', () {
    test("replace all elements", () {
      final list = mutableListOf(["a", "b", "c"]);
      list.fill("x");
      expect(list, listOf(["x", "x", "x"]));
    });

    test("on empty list", () {
      final list = mutableListOf<String>([]);
      list.fill("x");
      expect(list, emptyList());
    });
  });

  group("sorted", () {
    var lastChar = (String it) {
      var last = it.runes.last;
      return String.fromCharCode(last);
    };

    test("sortBy", () {
      final result = mutableListOf(["paul", "john", "max", "lisa"])
        ..sortBy(lastChar);
      expect(result, listOf(["lisa", "paul", "john", "max"]));
    });

    test("sortByDescending", () {
      final result = mutableListOf(["paul", "john", "max", "lisa"])
        ..sortByDescending(lastChar);
      expect(result, listOf(["max", "john", "paul", "lisa"]));
    });
  });
}
