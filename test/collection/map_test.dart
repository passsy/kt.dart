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

  group("equals", () {
    test("equals altough only subtypes", () {
      expect(mapOf<int, String>({1: "a", 2: "b"}),
          mapOf<num, String>({1: "a", 2: "b"}));
      expect(mapOf<num, String>({1: "a", 2: "b"}),
          mapOf<int, String>({1: "a", 2: "b"}));
      expect(mapOf<String, int>({"a": 1, "b": 2}),
          mapOf<String, num>({"a": 1, "b": 2}));
      expect(mapOf<String, num>({"a": 1, "b": 2}),
          mapOf<String, int>({"a": 1, "b": 2}));
    });
  });
}
