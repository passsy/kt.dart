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
}
