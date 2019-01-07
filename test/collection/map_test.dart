import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group("mapFrom", () {
    testMap(<K, V>(Map<K, V> map) => mapFrom<K, V>(map));
  });
  group("KMap.from", () {
    testMap(<K, V>(Map<K, V> map) => KMap<K, V>.from(map));
  });
  group("mutableMapFrom", () {
    testMap(<K, V>(Map<K, V> map) => mutableMapFrom<K, V>(map));
  });
  group("KMutableMap.from", () {
    testMap(<K, V>(Map<K, V> map) => KMutableMap<K, V>.from(map));
  });
  group("hashMapFrom", () {
    testMap(<K, V>(Map<K, V> map) => hashMapFrom<K, V>(map));
  });
  group("KHashMap", () {
    testMap(<K, V>(Map<K, V> map) => KHashMap<K, V>.from(map));
  });
  group("linkedMapOf", () {
    testMap(<K, V>(Map<K, V> map) => linkedMapFrom<K, V>(map));
  });
  group("KLinkedMap", () {
    testMap(<K, V>(Map<K, V> map) => KLinkedMap<K, V>.from(map));
  });
}

void testMap(KMap<K, V> Function<K, V>(Map<K, V> map) mapFrom,
    {bool ordered = true}) {
  group('basic methods', () {
    test("access dart map", () {
      Map<String, int> map = mapFrom<String, int>({"a": 1, "b": 2}).map;
      expect(map.length, 2);
      expect(map, equals({"a": 1, "b": 2}));
    });

    test("entry converts to KPair", () {
      var pair = mapFrom({"a": 1}).entries.first().toPair();
      expect(pair, KPair("a", 1));
    });
  });

  group("toString", () {
    test("with content", () {
      final map = mapFrom({"a": 1});
      expect(map.toString(), "{a=1}");
    });
    test("empty", () {
      final map = emptyMap();
      expect(map.toString(), "{}");
    });
  });

  group("equals", () {
    test("equals altough only subtypes", () {
      expect(mapFrom<int, String>({1: "a", 2: "b"}),
          mapFrom<num, String>({1: "a", 2: "b"}));
      expect(mapFrom<num, String>({1: "a", 2: "b"}),
          mapFrom<int, String>({1: "a", 2: "b"}));
      expect(mapFrom<String, int>({"a": 1, "b": 2}),
          mapFrom<String, num>({"a": 1, "b": 2}));
      expect(mapFrom<String, num>({"a": 1, "b": 2}),
          mapFrom<String, int>({"a": 1, "b": 2}));
    });
  });

  group("containsKey", () {
    final map = mapFrom({1: "test"});
    test("contains", () {
      expect(map.containsKey(1), isTrue);
    });
    test("doesn't contain", () {
      expect(map.containsKey(2), isFalse);
    });
    test("doesn't contain null", () {
      expect(map.containsKey(null), isFalse);
    });

    final nullMap = mapFrom({1: "test", null: "asdf"});
    test("doesn't contain null", () {
      expect(nullMap.containsKey(null), isTrue);
    });
  });

  group("containsValue", () {
    final map = mapFrom({1: "test"});
    test("contains", () {
      expect(map.containsValue("test"), isTrue);
    });
    test("doesn't contain", () {
      expect(map.containsValue("asdf"), isFalse);
    });
    test("doesn't contain null", () {
      expect(map.containsValue(null), isFalse);
    });

    final nullMap = mapFrom({1: "test", 2: null});
    test("doesn't contain null", () {
      expect(nullMap.containsValue(null), isTrue);
    });
  });

  group("getOrDefault", () {
    test("get", () {
      final pokemon = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrDefault(1, "Ditto"), equals("Bulbasaur"));
    });
    test("return default", () {
      final pokemon = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrDefault(0, "Ditto"), equals("Ditto"));
    });
  });

  group("isEmpty", () {
    test("isEmpty", () {
      expect(emptyMap().isEmpty(), isTrue);
    });
    test("is not empty", () {
      expect(mapFrom({1: "a"}).isEmpty(), isFalse);
    });
  });

  group("values", () {
    test("values", () {
      final pokemon = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.values, listOf("Bulbasaur", "Ivysaur"));
    });
  });
}
