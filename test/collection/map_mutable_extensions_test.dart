import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group("mutableMapFrom", () {
    testMutableMap(<K, V>() => mutableMapFrom<K, V>(),
        <K, V>(Map<K, V> map) => mutableMapFrom<K, V>(map));
  });
  group("KtMutableMap", () {
    testMutableMap(<K, V>() => KtMutableMap<K, V>.empty(),
        <K, V>(Map<K, V> map) => KtMutableMap<K, V>.from(map));
  });
  group("hashMapFrom", () {
    testMutableMap(<K, V>() => hashMapFrom<K, V>(),
        <K, V>(Map<K, V> map) => hashMapFrom<K, V>(map),
        ordered: false);
  });
  group("KHashMap", () {
    testMutableMap(<K, V>() => KtHashMap<K, V>.empty(),
        <K, V>(Map<K, V> map) => KtHashMap<K, V>.from(map),
        ordered: false);
  });
  group("linkedMapFrom", () {
    testMutableMap(<K, V>() => linkedMapFrom<K, V>(),
        <K, V>(Map<K, V> map) => linkedMapFrom<K, V>(map));
  });
  group("KLinkedMap", () {
    testMutableMap(<K, V>() => KtLinkedMap<K, V>.empty(),
        <K, V>(Map<K, V> map) => KtLinkedMap<K, V>.from(map));
  });
}

void testMutableMap(KtMutableMap<K, V> Function<K, V>() emptyMap,
    KtMutableMap<K, V> Function<K, V>(Map<K, V> map) mutableMapFrom,
    {bool ordered = true}) {
  group("clear", () {
    test("clear items", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.clear();
      expect(pokemon, emptyMap());
    });
  });

  group("contains", () {
    test("contains key", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.containsKey(1), isTrue);
      expect(pokemon.containsKey(2), isTrue);
    });

    test("doesn't contain key", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.containsKey(null), isFalse);
      expect(pokemon.containsKey(-1), isFalse);
    });
    test("contains value", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.containsValue("Bulbasaur"), isTrue);
      expect(pokemon.containsValue("Ivysaur"), isTrue);
    });

    test("doesn't contain value", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.containsValue(null), isFalse);
      expect(pokemon.containsValue("other"), isFalse);
    });
  });

  group("count", () {
    test("empty", () {
      expect(emptyMap<String, int>().count(), 0);
    });

    test("count elements", () {
      expect(mapFrom({1: "a", 2: "b"}).count(), 2);
    });

    test("count even", () {
      final map = mapFrom({1: "a", 2: "b", 3: "c"});
      expect(map.count((it) => it.key % 2 == 0), 1);
    });
  });

  group("get", () {
    test("get", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.get(1), "Bulbasaur");
    });

    test("get not found returns null", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.get(3), null);
    });

    test("get operator", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon[1], "Bulbasaur");
    });

    test("getValue", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getValue(2), "Ivysaur");
    });

    test("getValue not found throws", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(() => pokemon.getValue(3), throwsException);
    });
  });

  group("getOrDefault", () {
    test("get", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrDefault(1, "Ditto"), equals("Bulbasaur"));
    });
    test("return default", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrDefault(0, "Ditto"), equals("Ditto"));
    });
  });

  group("getOrPut", () {
    test("get", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrPut(1, () => "asdf"), "Bulbasaur");
    });

    test("put", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.getOrPut(150, () => "Mewtwo"), "Mewtwo");
      expect(pokemon.get(150), "Mewtwo");
    });

    test("getOrPut doens't allow null as defaultValue function", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final e = catchException<ArgumentError>(() => pokemon.getOrPut(1, null));
      expect(e.message, allOf(contains("null"), contains("defaultValue")));
    });
  });

  group("iterator", () {
    test("iterator is iterates", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final KtMutableIterator<KtMapEntry<int, String>> i = pokemon.iterator();
      expect(i.hasNext(), isTrue);
      var next = i.next();
      expect(next.key, 1);
      expect(next.value, "Bulbasaur");

      expect(i.hasNext(), isTrue);
      next = i.next();
      expect(next.key, 2);
      expect(next.value, "Ivysaur");

      expect(i.hasNext(), isFalse);
    });

    group("remove doesn't work", () {
      test("iterator is iterates", () {
        final pokemon = mutableMapFrom({
          1: "Bulbasaur",
          2: "Ivysaur",
        });
        final KtMutableIterator<KtMapEntry<int, String>> i = pokemon.iterator();
        expect(i.hasNext(), isTrue);
        final next = i.next();
        expect(next.key, 1);
        expect(next.value, "Bulbasaur");

        // TODO replace error assertion with value assertion when https://github.com/passsy/dart_kollection/issues/5 has been fixed
        final e = catchException(() => i.remove());
        expect(e, equals(const TypeMatcher<UnimplementedError>()));
        // removed first item
        //expect(pokemon, mapFrom({2: "Ivysaur"}));
      });
    });
  });

  group("put", () {
    test("put", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.put(1, "Dito"), "Bulbasaur");
      expect(pokemon.get(1), "Dito");
    });

    test("operator", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon[1] = "Dito";
      expect(pokemon[1], "Dito");
    });
  });

  group("putAll", () {
    test("putAll", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putAll(mapFrom({1: "Ditto", 3: "Venusaur"}));
      expect(pokemon[1], "Ditto");
      expect(pokemon[2], "Ivysaur");
      expect(pokemon[3], "Venusaur");
    });

    test("can't use null for putAll", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final e = catchException<ArgumentError>(() => pokemon.putAll(null));
      expect(e.message, allOf(contains("null")));
    });
  });

  group("putAllPairs", () {
    test("add new ones", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putAllPairs(listFrom([
        KtPair(2, "Dito"),
        KtPair(3, "Venusaur"),
        KtPair(4, "Charmander"),
      ]));
      expect(pokemon.size, 4);
      expect(pokemon[3], "Venusaur");
      expect(pokemon[4], "Charmander");
      expect(pokemon[2], "Dito");
    });

    test("override", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putAllPairs(listFrom([
        KtPair(2, "Dito"),
      ]));
      expect(pokemon.size, 2);
      expect(pokemon[2], "Dito");
    });

    test("putAllPairs doens't allow null as argument", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final e = catchException<ArgumentError>(() => pokemon.putAllPairs(null));
      expect(e.message, allOf(contains("null"), contains("pairs")));
    });
  });

  group("putIfAbsent", () {
    test("insert", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putIfAbsent(3, "Venusaur");
      expect(pokemon.size, 3);
      expect(pokemon[3], "Venusaur");
    });

    test("don't replace", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putIfAbsent(2, "Venusaur");
      expect(pokemon.size, 2);
      expect(pokemon[2], "Ivysaur");
    });

    test("replace when mapped to null", () {
      final pokemon = mutableMapFrom({
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
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.removeMapping(2, "Ivysaur"), isTrue);
      expect(pokemon, mapFrom({1: "Bulbasaur"}));
    });

    test("don't remove when key doesn't match", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.removeMapping(52, "Ivysaur"), isFalse);
      expect(pokemon.size, equals(2));
    });

    test("don't remove when value doesn't match", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.removeMapping(2, "Ditto"), isFalse);
      expect(pokemon.size, equals(2));
    });
  });

  group("values", () {
    test("returns values", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.values, listOf("Bulbasaur", "Ivysaur"));
    });
    test("empty", () {
      expect(mutableListOf(), emptyList());
    });

    test("values with null", () {
      final pokemon = mutableMapFrom({
        0: null,
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.values, listFrom([null, "Bulbasaur", "Ivysaur"]));
    });
  });
}
