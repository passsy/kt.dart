import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  final pokemon = mapOf({
    1: "Bulbasaur",
    2: "Ivysaur",
  });

  group("get", () {
    test("get", () {
      expect(pokemon.get(1), "Bulbasaur");
    });

    test("get not found returns null", () {
      expect(pokemon.get(3), null);
    });

    test("get operator", () {
      expect(pokemon[1], "Bulbasaur");
    });

    test("getValue", () {
      expect(pokemon.getValue(2), "Ivysaur");
    });

    test("getValue not found throws", () {
      expect(() => pokemon.getValue(3), throwsException);
    });

    test("getOrElse", () {
      expect(pokemon.getOrElse(10, () => "None"), "None");
    });
  });

  group("iterator", () {
    test("iterate", () {
      var iterator = pokemon.iterator();
      expect(iterator.next().value, "Bulbasaur");
      expect(iterator.next().value, "Ivysaur");
      expect(iterator.hasNext(), false);
    });
  });

  group("map keys", () {
    test("map keys", () {
      final mapped = pokemon.mapKeys((entry) => entry.key.toString());
      expect(mapped["1"], "Bulbasaur");
      expect(mapped["2"], "Ivysaur");
      expect(mapped.size, 2);
    });
  });

  group("map values", () {
    test("map values", () {
      final mapped = pokemon.mapValues((entry) => entry.value.toUpperCase());
      expect(mapped[1], "BULBASAUR");
      expect(mapped[2], "IVYSAUR");
      expect(mapped.size, 2);
    });
  });
}
