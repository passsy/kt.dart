import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
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
  });

  group("putAllPairs", () {
    test("add new ones", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      pokemon.putAllPairs(listOf([
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
      pokemon.putAllPairs(listOf([
        KPair(2, "Dito"),
      ]));
      expect(pokemon.size, 2);
      expect(pokemon[2], "Dito");
    });
  });
}
