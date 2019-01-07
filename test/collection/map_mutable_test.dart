import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group("mutableMapFrom", () {
    testMutableMap(<K, V>(Map<K, V> map) => mutableMapFrom<K, V>(map));
  });
  group("KMutableMap.from", () {
    testMutableMap(<K, V>(Map<K, V> map) => KMutableMap<K, V>.from(map));
  });
  group("hashMapFrom", () {
    testMutableMap(<K, V>(Map<K, V> map) => hashMapFrom<K, V>(map),
        ordered: false);
  });
  group("KHashMap", () {
    testMutableMap(<K, V>(Map<K, V> map) => KHashMap<K, V>.from(map),
        ordered: false);
  });
  group("linkedMapFrom", () {
    testMutableMap(<K, V>(Map<K, V> map) => linkedMapFrom<K, V>(map));
  });
  group("KLinkedMap", () {
    testMutableMap(<K, V>(Map<K, V> map) => KLinkedMap<K, V>.from(map));
  });
}

void testMutableMap(
    KMutableMap<K, V> Function<K, V>(Map<K, V> map) mutableMapFrom,
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
          listOf(KPair(1, "Bulbasaur"), KPair(2, "Ivysaur")));
    });

    test("set value for mutable entry", () {
      final pokemon = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });

      final e = catchException(() {
        pokemon.entries.forEach((entry) {
          entry.setValue(entry.value.toUpperCase());
        });
      });

      // TODO exchange error check with assertion once https://github.com/passsy/dart_kollection/issues/55 has been fixed
      expect(e, TypeMatcher<UnimplementedError>());
      // expect(
      //    pokemon,
      //     mapFrom({
      //       1: "BULBASAUR",
      //      2: "IVYSAUR",
      //    }));
    });
  });
}
