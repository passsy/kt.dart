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

  group("containsKey", () {
    final map = mapOf({1: "test"});
    test("contains", () {
      expect(map.containsKey(1), isTrue);
    });
    test("doesn't contain", () {
      expect(map.containsKey(2), isFalse);
    });
    test("doesn't contain null", () {
      expect(map.containsKey(null), isFalse);
    });

    final nullMap = mapOf({1: "test", null: "asdf"});
    test("doesn't contain null", () {
      expect(nullMap.containsKey(null), isTrue);
    });
  });

  group("containsValue", () {
    final map = mapOf({1: "test"});
    test("contains", () {
      expect(map.containsValue("test"), isTrue);
    });
    test("doesn't contain", () {
      expect(map.containsValue("asdf"), isFalse);
    });
    test("doesn't contain null", () {
      expect(map.containsValue(null), isFalse);
    });

    final nullMap = mapOf({1: "test", 2: null});
    test("doesn't contain null", () {
      expect(nullMap.containsValue(null), isTrue);
    });
  });

  group("getOrDefault", () {
    test("get", () {
      final pokemon = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrDefault(1, "Ditto"), equals("Bulbasaur"));
    });
    test("return default", () {
      final pokemon = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrDefault(0, "Ditto"), equals("Ditto"));
    });
  });

  group("isEmpty", () {
    test("isEmpty", () {
      expect(mapOf().isEmpty(), isTrue);
    });
    test("is not empty", () {
      expect(mapOf({1: "a"}).isEmpty(), isFalse);
    });
  });

  group("values", () {
    test("values", () {
      final pokemon = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.values, listOf("Bulbasaur", "Ivysaur"));
    });
  });
}
