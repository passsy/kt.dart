import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group("clear", () {
    test("clear items", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.clear();
      expect(pokemon, emptyMap());
    });
  });

  group("contains", () {
    test("contains key", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.containsKey(1), isTrue);
      expect(pokemon.containsKey(2), isTrue);
    });

    test("doesn't contain key", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.containsKey(null), isFalse);
      expect(pokemon.containsKey(-1), isFalse);
    });
    test("contains value", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.containsValue("Bulbasaur"), isTrue);
      expect(pokemon.containsValue("Ivysaur"), isTrue);
    });

    test("doesn't contain value", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.containsValue(null), isFalse);
      expect(pokemon.containsValue("other"), isFalse);
    });
  });

  group("get", () {
    test("get", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.get(1), "Bulbasaur");
    });

    test("get not found returns null", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.get(3), null);
    });

    test("get operator", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon[1], "Bulbasaur");
    });

    test("getValue", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getValue(2), "Ivysaur");
    });

    test("getValue not found throws", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(() => pokemon.getValue(3), throwsException);
    });
  });

  group("getOrDefault", () {
    test("get", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrDefault(1, "Ditto"), equals("Bulbasaur"));
    });
    test("return default", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrDefault(0, "Ditto"), equals("Ditto"));
    });
  });

  group("getOrPut", () {
    test("get", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrPut(1, () => "asdf"), "Bulbasaur");
    });

    test("put", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrPut(150, () => "Mewtwo"), "Mewtwo");
      expect(pokemon.get(150), "Mewtwo");
    });

    test("getOrPut doens't allow null as defaultValue function", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final e = catchException<ArgumentError>(() => pokemon.getOrPut(1, null));
      expect(e.message, allOf(contains("null"), contains("defaultValue")));
    });
  });

  group("put", () {
    test("put", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.put(1, "Dito"), "Bulbasaur");
      expect(pokemon.get(1), "Dito");
    });

    test("operator", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon[1] = "Dito";
      expect(pokemon[1], "Dito");
    });
  });

  group("putAll", () {
    test("putAll", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putAll(mapOf({1: "Ditto", 3: "Venusaur"}));
      expect(pokemon[1], "Ditto");
      expect(pokemon[2], "Ivysaur");
      expect(pokemon[3], "Venusaur");
    });

    test("can't use null for putAll", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final e = catchException<ArgumentError>(() => pokemon.putAll(null));
      expect(e.message, allOf(contains("null")));
    });
  });

  group("putAllPairs", () {
    test("add new ones", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putAllPairs(listFrom([
        KPair(2, "Dito"),
        KPair(3, "Venusaur"),
        KPair(4, "Charmander"),
      ]));
      expect(pokemon.size, 4);
      expect(pokemon[3], "Venusaur");
      expect(pokemon[4], "Charmander");
      expect(pokemon[2], "Dito");
    });

    test("override", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putAllPairs(listFrom([
        KPair(2, "Dito"),
      ]));
      expect(pokemon.size, 2);
      expect(pokemon[2], "Dito");
    });

    test("putAllPairs doens't allow null as argument", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final e = catchException<ArgumentError>(() => pokemon.putAllPairs(null));
      expect(e.message, allOf(contains("null"), contains("pairs")));
    });
  });

  group("putIfAbsent", () {
    test("insert", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putIfAbsent(3, "Venusaur");
      expect(pokemon.size, 3);
      expect(pokemon[3], "Venusaur");
    });

    test("don't replace", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putIfAbsent(2, "Venusaur");
      expect(pokemon.size, 2);
      expect(pokemon[2], "Ivysaur");
    });

    test("replace when mapped to null", () {
      final pokemon = mutableMapOf({
        1: null,
        2: "Ivysaur",
      });
      pokemon.putIfAbsent(1, "Mew");
      expect(pokemon.size, 2);
      expect(pokemon[1], "Mew");
    });
  });

  group("removeMapping", () {
    test("remove", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.removeMapping(2, "Ivysaur"), isTrue);
      expect(pokemon, mapOf({1: "Bulbasaur"}));
    });

    test("don't remove when key doesn't match", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.removeMapping(52, "Ivysaur"), isFalse);
      expect(pokemon.size, equals(2));
    });

    test("don't remove when value doesn't match", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.removeMapping(2, "Ditto"), isFalse);
      expect(pokemon.size, equals(2));
    });
  });

  group("values", () {
    test("returns values", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.values, listOf("Bulbasaur", "Ivysaur"));
    });
    test("empty", () {
      expect(mutableListOf(), emptyList());
    });

    test("values with null", () {
      final pokemon = mutableMapOf({
        0: null,
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.values, listOf(null, "Bulbasaur", "Ivysaur"));
    });
  });
}
