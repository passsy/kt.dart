import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('basic methods', () {
    test("access dart map", () {
      Map<String, int> map = mapOf<String, int>({"a": 1, "b": 2}).map;
      expect(map.length, 2);
      expect(map, equals({"a": 1, "b": 2}));
    });

    test("entry converts to KPair", () {
      var pair = mapOf({"a": 1}).entries.first().toPair();
      expect(pair, KPair("a", 1));
    });
  });

  group("toString", () {
    test("with content", () {
      final map = mapOf({"a": 1});
      expect(map.toString(), "{a=1}");
    });
    test("empty", () {
      final map = emptyMap();
      expect(map.toString(), "{}");
    });
  });
}
