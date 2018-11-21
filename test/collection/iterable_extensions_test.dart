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

  group("drop", () {
    test("drop first value", () {
      final list = listOf(["a", "b", "c"]);
      expect(list.drop(1), equals(listOf(["b", "c"])));
    });
    // TODO drop on empty
  });
}
