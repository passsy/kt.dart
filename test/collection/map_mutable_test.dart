import "package:kt_dart/collection.dart";
import "package:test/test.dart";

void main() {
  group("KtMutableMap", () {
    group("mutableMapFrom", () {
      testMutableMap(<K, V>(Map<K, V> map) => mutableMapFrom<K, V>(map));
    });
    group("KtMutableMap.from", () {
      testMutableMap(<K, V>(Map<K, V> map) => KtMutableMap<K, V>.from(map));
    });
    group("hashMapFrom", () {
      testMutableMap(<K, V>(Map<K, V> map) => hashMapFrom<K, V>(map),
          ordered: false);
    });
    group("KtHashMap", () {
      testMutableMap(<K, V>(Map<K, V> map) => KtHashMap<K, V>.from(map),
          ordered: false);
    });
    group("linkedMapFrom", () {
      testMutableMap(<K, V>(Map<K, V> map) => linkedMapFrom<K, V>(map));
    });
    group("KtLinkedMap", () {
      testMutableMap(<K, V>(Map<K, V> map) => KtLinkedMap<K, V>.from(map));
    });
  });
}

void testMutableMap(
    KtMutableMap<K, V> Function<K, V>(Map<K, V> map) mutableMapFrom,
    {bool ordered = true}) {
  group("add item", () {
    test("add item", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.put(3, "Venusaur"), null);
      expect(pokemon.size, 3);
    });
    test("override item", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.put(2, "Ditto"), "Ivysaur");
      expect(pokemon.size, 2);
    });
  });
  group("remove item", () {
    test("remove item", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.remove(2), "Ivysaur");
      expect(pokemon.size, 1);
    });
  });

  group("_MutableEntry", () {
    test("entries can be converted to pairs", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.entries.map((it) => it.toPair()),
          listOf(const KtPair(1, "Bulbasaur"), const KtPair(2, "Ivysaur")));
    });

    test("set value for mutable entry", () {
      final pokemon = mutableMapFrom({1: "Bulbasaur", 2: "Ivysaur"});

      pokemon.entries.forEach((entry) {
        final oldValue = entry.value;
        final newValue = entry.value.toUpperCase();

        expect(entry.setValue(newValue), oldValue);
      });

      expect(pokemon, mapFrom({1: "BULBASAUR", 2: "IVYSAUR"}));
    });
  });
}
