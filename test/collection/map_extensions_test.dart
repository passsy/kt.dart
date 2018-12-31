import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  final pokemon = mapOf({
    1: "Bulbasaur",
    2: "Ivysaur",
  });

  group("filter", () {
    test("filter", () {
      final filtered = pokemon.filter((entry) => entry.value.startsWith("I"));
      expect(filtered, mapOf({2: "Ivysaur"}));
    });
    test("filter requires predicate to be non null", () {
      final e = catchException<ArgumentError>(() => pokemon.filter(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("filterNot", () {
    test("filterNot", () {
      final filtered =
          pokemon.filterNot((entry) => entry.value.startsWith("I"));
      expect(filtered, mapOf({1: "Bulbasaur"}));
    });
    test("filterNot requires predicate to be non null", () {
      final e = catchException<ArgumentError>(() => pokemon.filterNot(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("filterTo", () {
    test("filterTo same type", () {
      final result = mutableMapOf<int, String>();
      final filtered =
          pokemon.filterTo(result, (entry) => entry.value.startsWith("I"));
      expect(identical(result, filtered), isTrue);
      expect(result, mapOf({2: "Ivysaur"}));
    });
    test("filterTo super type", () {
      final result = mutableMapOf<num, String>();
      final filtered =
          pokemon.filterTo(result, (entry) => entry.value.startsWith("I"));
      expect(identical(result, filtered), isTrue);
      expect(result, mapOf({2: "Ivysaur"}));
    });
    test("filterTo wrong type throws", () {
      final result = mutableMapOf<String, String>();
      final e = catchException<ArgumentError>(() =>
          pokemon.filterTo(result, (entry) => entry.value.startsWith("I")));
      expect(
          e.message,
          allOf(contains("filterTo"), contains("destination"),
              contains("<String, String>"), contains("<int, String>")));
    });
    test("filterTo requires predicate to be non null", () {
      bool Function(KMapEntry<int, String> entry) predicate = null;
      var other = mutableMapOf<int, String>();
      final e = catchException<ArgumentError>(
          () => pokemon.filterTo(other, predicate));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
    test("filterTo requires destination to be non null", () {
      final e = catchException<ArgumentError>(
          () => pokemon.filterTo(null, (it) => true));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("filterNotTo", () {
    test("filterNotTo same type", () {
      final result = mutableMapOf<int, String>();
      final filtered =
          pokemon.filterNotTo(result, (entry) => entry.value.startsWith("I"));
      expect(identical(result, filtered), isTrue);
      expect(result, mapOf({1: "Bulbasaur"}));
    });
    test("filterNotTo super type", () {
      final result = mutableMapOf<num, String>();
      final filtered =
          pokemon.filterNotTo(result, (entry) => entry.value.startsWith("I"));
      expect(identical(result, filtered), isTrue);
      expect(result, mapOf({1: "Bulbasaur"}));
    });
    test("filterNotTo wrong type throws", () {
      final result = mutableMapOf<String, String>();
      final e = catchException<ArgumentError>(() =>
          pokemon.filterNotTo(result, (entry) => entry.value.startsWith("I")));
      expect(
          e.message,
          allOf(contains("filterNotTo"), contains("destination"),
              contains("<String, String>"), contains("<int, String>")));
    });
    test("filterNotTo requires predicate to be non null", () {
      bool Function(KMapEntry<int, String> entry) predicate = null;
      var other = mutableMapOf<int, String>();
      final e = catchException<ArgumentError>(
          () => pokemon.filterNotTo(other, predicate));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
    test("filterNotTo requires destination to be non null", () {
      final e = catchException<ArgumentError>(
          () => pokemon.filterNotTo(null, (it) => true));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
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

    test("getOrElse doesn't allow null as defaultValue function", () {
      final e =
          catchException<ArgumentError>(() => pokemon.getOrElse(10, null));
      expect(e.message, allOf(contains("null"), contains("defaultValue")));
    });
  });

  group("isEmpty", () {
    test("is empty", () {
      expect(mutableMapOf({}).isEmpty(), true);
      expect(emptyMap().isEmpty(), true);
    });
    test("is not empty", () {
      expect(mutableMapOf({1: "a"}).isEmpty(), false);
    });
  });

  group("isNotEmpty", () {
    test("is empty", () {
      expect(mutableMapOf({}).isNotEmpty(), false);
      expect(emptyMap().isNotEmpty(), false);
    });
    test("is not empty", () {
      expect(mutableMapOf({1: "a"}).isNotEmpty(), true);
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

  group("mapKeys", () {
    test("map keys", () {
      final mapped = pokemon.mapKeys((entry) => entry.key.toString());
      expect(mapped["1"], "Bulbasaur");
      expect(mapped["2"], "Ivysaur");
      expect(mapped.size, 2);
    });
  });

  group("mapKeysTo", () {
    test("mapKeysTo same type", () {
      final result = mutableMapOf<int, String>();
      final filtered = pokemon.mapKeysTo(result, (entry) => entry.key + 1000);
      expect(identical(result, filtered), isTrue);
      expect(
          result,
          mapOf({
            1001: "Bulbasaur",
            1002: "Ivysaur",
          }));
    });
    test("mapKeysTo super type", () {
      final result = mutableMapOf<num, String>();
      final filtered = pokemon.mapKeysTo(result, (entry) => entry.key + 1000);
      expect(identical(result, filtered), isTrue);
      expect(
          result,
          mapOf({
            1001: "Bulbasaur",
            1002: "Ivysaur",
          }));
    });
    test("mapKeysTo wrong type throws", () {
      final result = mutableMapOf<String, String>();
      final e = catchException<ArgumentError>(
          () => pokemon.mapKeysTo(result, (entry) => entry.key + 1000));
      expect(
          e.message,
          allOf(
            contains("mapKeysTo"),
            contains("destination"),
            contains("<String, String>"),
            contains("<int, String>"),
          ));
    });
    test("mapKeysTo requires transform to be non null", () {
      bool Function(KMapEntry<int, String> entry) predicate = null;
      var other = mutableMapOf<int, String>();
      final e = catchException<ArgumentError>(
          () => pokemon.mapKeysTo(other, predicate));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });
    test("mapKeysTo requires destination to be non null", () {
      final e = catchException<ArgumentError>(
          () => pokemon.mapKeysTo(null, (it) => true));
      expect(e.message, allOf(contains("null"), contains("destination")));
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

  group("minus", () {
    test("remove element", () {
      final map = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map.minus(1);
      expect(result.size, 1);
      expect(result, mapOf({2: "Ivysaur"}));
      expect(map.size, 2);
    });

    test("- (minus) operator", () {
      final map = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map - 1;
      expect(result.size, 1);
      expect(result, mapOf({2: "Ivysaur"}));
      expect(map.size, 2);
    });

    test("-= (minusAssign) operator", () {
      var map = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      map -= 1;
      expect(map.size, 1);
      expect(map, mapOf({2: "Ivysaur"}));
    });

    test("do nothing when key doesn't exist", () {
      final map = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map.minus(5);
      expect(result, map);
    });
  });

  group("plus", () {
    test("add element", () {
      final map = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map.plus(mapOf({3: "Venusaur"}));
      expect(result.size, 3);
      expect(result[3], "Venusaur");
      expect(map.size, 2);
    });

    test("plus doesn't allow null as argument", () {
      final pokemon = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final e = catchException<ArgumentError>(() => pokemon.plus(null));
      expect(e.message, allOf(contains("null"), contains("map")));
    });

    test("+ (plus) operator", () {
      final map = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map + mapOf({3: "Venusaur"});
      expect(result.size, 3);
      expect(result[3], "Venusaur");
      expect(map.size, 2);
    });

    test("+= (plusAssign) operator", () {
      var map = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      map += mapOf({3: "Venusaur"});
      expect(map.size, 3);
      expect(map[3], "Venusaur");
      expect(map.size, 3);
    });

    test("override existing mapping", () {
      final map = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map.plus(mapOf({2: "Dito"}));
      expect(result.size, 2);
      expect(map.size, 2);
      expect(result[2], "Dito");
      expect(map[2], "Ivysaur");
      expect(result, isNot(equals(map)));
    });
  });

  group("toMap", () {
    test("makes a copy which doesn't share memory", () {
      final map = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final copy = map.toMap();
      expect(copy, map);
      map.put(3, "Venusaur");
      expect(map.size, 3);
      expect(copy.size, 2);
    });

    test("make a copy of an empty list", () {
      final map = emptyMap();
      final copy = map.toMap();
      expect(copy, map);
    });
  });

  group("toMutableMap", () {
    test("makes a copy", () {
      var map = mapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final copy = map.toMutableMap();
      expect(map, copy);
      copy.put(3, "Venusaur");
      expect(copy.size, 3);
      expect(map.size, 2);
    });
  });
}
