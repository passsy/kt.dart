import "package:kt_dart/collection.dart";
import "package:kt_dart/src/util/hash.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("mapFrom", () {
    testMap(<K, V>() => emptyMap<K, V>(),
        <K, V>(Map<K, V> map) => mapFrom<K, V>(map));
  });
  group("KtMap.from", () {
    testMap(<K, V>() => emptyMap<K, V>(),
        <K, V>(Map<K, V> map) => KtMap<K, V>.from(map));
  });
  group("mutableMapFrom", () {
    testMap(<K, V>() => mutableMapFrom<K, V>(),
        <K, V>(Map<K, V> map) => mutableMapFrom<K, V>(map));
  });
  group("KtMutableMap.from", () {
    testMap(<K, V>() => KtMutableMap<K, V>.empty(),
        <K, V>(Map<K, V> map) => KtMutableMap<K, V>.from(map));
  });
  group("hashMapFrom", () {
    testMap(<K, V>() => hashMapFrom<K, V>(),
        <K, V>(Map<K, V> map) => hashMapFrom<K, V>(map),
        ordered: false);
  });
  group("KHashMap", () {
    testMap(<K, V>() => KtHashMap<K, V>.empty(),
        <K, V>(Map<K, V> map) => KtHashMap<K, V>.from(map),
        ordered: false);
  });
  group("linkedMapFrom", () {
    testMap(<K, V>() => linkedMapFrom<K, V>(),
        <K, V>(Map<K, V> map) => linkedMapFrom<K, V>(map));
  });
  group("KLinkedMap", () {
    testMap(<K, V>() => KtLinkedMap<K, V>.empty(),
        <K, V>(Map<K, V> map) => KtLinkedMap<K, V>.from(map));
  });
  group("ThirdPartyMap", () {
    testMap(<K, V>() => ThirdPartyMap<K, V>(),
        <K, V>(Map<K, V> map) => ThirdPartyMap<K, V>(map));
  });
}

void testMap(KtMap<K, V> Function<K, V>() emptyMap,
    KtMap<K, V> Function<K, V>(Map<K, V> map) mapFrom,
    {bool ordered = true}) {
  final pokemon = mapFrom({
    1: "Bulbasaur",
    2: "Ivysaur",
  });

  group("all", () {
    test("all() non-empty map", () {
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
        3: "Stegosaur",
      });
      expect(map.all((key, value) => key > 0 && value.contains("aur")), true);
      expect(map.all((key, value) => value == "Bulbasaur"), false);
      expect(map.all((key, value) => value.isNotEmpty), true);
    });

    test("all() empty map", () {
      final map = emptyMap();
      expect(map.none((key, value) => key == 1 && value == "Bulbasaur"), true);
      expect(map.none((key, value) => false), true);
    });

    test("predicate must be non null", () {
      final e = catchException<ArgumentError>(() => emptyMap().all(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("any", () {
    test("any() non-empty map", () {
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
        3: "Stegosaur",
      });
      expect(map.any((key, value) => value == "Bulbasaur"), true);
      expect(map.any((key, _) => key == -35), false);
    });

    test("any() empty map", () {
      final map = emptyMap();
      expect(map.any((key, value) => key == 1 && value == "Bulbasaur"), false);
      expect(map.any((key, value) => true), false);
      expect(map.any((key, value) => false), false);
    });

    test("predicate must be non null", () {
      final e = catchException<ArgumentError>(() => emptyMap().any(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("filter", () {
    test("filter", () {
      final filtered = pokemon.filter((entry) => entry.value.startsWith("I"));
      expect(filtered, mapFrom({2: "Ivysaur"}));
    });
    test("filter requires predicate to be non null", () {
      final e = catchException<ArgumentError>(() => pokemon.filter(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("filterKeys", () {
    test("filterKeys", () {
      final filtered = pokemon.filterKeys((k) => k == 2);
      expect(filtered, mapFrom({2: "Ivysaur"}));
    });
    test("filterKeys requires predicate to be non null", () {
      final e = catchException<ArgumentError>(() => pokemon.filterKeys(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("filterValues", () {
    test("filterValues", () {
      final filtered = pokemon.filterValues((v) => v.startsWith("I"));
      expect(filtered, mapFrom({2: "Ivysaur"}));
    });
    test("filterValues requires predicate to be non null", () {
      final e = catchException<ArgumentError>(() => pokemon.filterValues(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("filterNot", () {
    test("filterNot", () {
      final filtered =
          pokemon.filterNot((entry) => entry.value.startsWith("I"));
      expect(filtered, mapFrom({1: "Bulbasaur"}));
    });
    test("filterNot requires predicate to be non null", () {
      final e = catchException<ArgumentError>(() => pokemon.filterNot(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });

  group("filterTo", () {
    test("filterTo same type", () {
      final result = mutableMapFrom<int, String>();
      final filtered =
          pokemon.filterTo(result, (entry) => entry.value.startsWith("I"));
      expect(identical(result, filtered), isTrue);
      expect(result, mapFrom({2: "Ivysaur"}));
    });
    test("filterTo super type", () {
      final result = mutableMapFrom<num, String>();
      final filtered =
          pokemon.filterTo(result, (entry) => entry.value.startsWith("I"));
      expect(identical(result, filtered), isTrue);
      expect(result, mapFrom({2: "Ivysaur"}));
    });
    test("filterTo wrong type throws", () {
      final result = mutableMapFrom<String, String>();
      final e = catchException<ArgumentError>(() =>
          pokemon.filterTo(result, (entry) => entry.value.startsWith("I")));
      expect(
          e.message,
          allOf(contains("filterTo"), contains("destination"),
              contains("<String, String>"), contains("<int, String>")));
    });
    test("filterTo requires predicate to be non null", () {
      const bool Function(KtMapEntry<int, String> entry) predicate = null;
      final other = mutableMapFrom<int, String>();
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
      final result = mutableMapFrom<int, String>();
      final filtered =
          pokemon.filterNotTo(result, (entry) => entry.value.startsWith("I"));
      expect(identical(result, filtered), isTrue);
      expect(result, mapFrom({1: "Bulbasaur"}));
    });
    test("filterNotTo super type", () {
      final result = mutableMapFrom<num, String>();
      final filtered =
          pokemon.filterNotTo(result, (entry) => entry.value.startsWith("I"));
      expect(identical(result, filtered), isTrue);
      expect(result, mapFrom({1: "Bulbasaur"}));
    });
    test("filterNotTo wrong type throws", () {
      final result = mutableMapFrom<String, String>();
      final e = catchException<ArgumentError>(() =>
          pokemon.filterNotTo(result, (entry) => entry.value.startsWith("I")));
      expect(
          e.message,
          allOf(contains("filterNotTo"), contains("destination"),
              contains("<String, String>"), contains("<int, String>")));
    });
    test("filterNotTo requires predicate to be non null", () {
      const bool Function(KtMapEntry<int, String> entry) predicate = null;
      final other = mutableMapFrom<int, String>();
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
      expect(mutableMapFrom({}).isEmpty(), true);
      expect(emptyMap().isEmpty(), true);
    });
    test("is not empty", () {
      expect(mutableMapFrom({1: "a"}).isEmpty(), false);
    });
  });

  group("isNotEmpty", () {
    test("is empty", () {
      expect(mutableMapFrom({}).isNotEmpty(), false);
      expect(emptyMap().isNotEmpty(), false);
    });
    test("is not empty", () {
      expect(mutableMapFrom({1: "a"}).isNotEmpty(), true);
    });
  });

  group("iterator", () {
    test("iterate", () {
      final iterator = pokemon.iterator();
      expect(iterator.next().value, "Bulbasaur");
      expect(iterator.next().value, "Ivysaur");
      expect(iterator.hasNext(), false);
    });
  });

  group("map", () {
    test("map entries", () {
      final mapped = pokemon.map((entry) => "${entry.key}->${entry.value}");
      expect(mapped, listOf("1->Bulbasaur", "2->Ivysaur"));
      expect(mapped.size, 2);
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
      final result = mutableMapFrom<int, String>();
      final filtered = pokemon.mapKeysTo(result, (entry) => entry.key + 1000);
      expect(identical(result, filtered), isTrue);
      expect(
          result,
          mapFrom({
            1001: "Bulbasaur",
            1002: "Ivysaur",
          }));
    });
    test("mapKeysTo super type", () {
      final result = mutableMapFrom<num, String>();
      final filtered = pokemon.mapKeysTo(result, (entry) => entry.key + 1000);
      expect(identical(result, filtered), isTrue);
      expect(
          result,
          mapFrom({
            1001: "Bulbasaur",
            1002: "Ivysaur",
          }));
    });
    test("mapKeysTo wrong type throws", () {
      final result = mutableMapFrom<String, String>();
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
      const bool Function(KtMapEntry<int, String> entry) predicate = null;
      final other = mutableMapFrom<int, String>();
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

  group("mapTo", () {
    test("mapTo same type", () {
      final result = mutableListFrom<int>();
      final filtered = pokemon.mapTo(result, (entry) => entry.key + 1000);
      expect(identical(result, filtered), isTrue);
      expect(result, listOf(1001, 1002));
    });
    test("mapTo super type", () {
      final result = mutableListFrom<num>();
      final filtered = pokemon.mapTo(result, (entry) => entry.key + 1000);
      expect(identical(result, filtered), isTrue);
      expect(result, listOf(1001, 1002));
    });
    test("mapTo wrong type throws", () {
      final result = mutableListFrom<String>();
      final e = catchException<ArgumentError>(
          () => pokemon.mapTo(result, (entry) => entry.key + 1000));
      expect(
          e.message,
          allOf(
            contains("mapTo"),
            contains("destination"),
            contains("<String>"),
            contains("<int, String>"),
          ));
    });
    test("mapTo requires transform to be non null", () {
      const bool Function(KtMapEntry<int, String> entry) predicate = null;
      final other = mutableListFrom<int>();
      final e =
          catchException<ArgumentError>(() => pokemon.mapTo(other, predicate));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });
    test("mapTo requires destination to be non null", () {
      final e = catchException<ArgumentError>(
          () => pokemon.mapTo(null, (it) => true));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("mapValues", () {
    test("map values", () {
      final mapped = pokemon.mapValues((entry) => entry.value.toUpperCase());
      expect(mapped[1], "BULBASAUR");
      expect(mapped[2], "IVYSAUR");
      expect(mapped.size, 2);
    });
  });

  group("mapValuesTo", () {
    test("mapValuesTo same type", () {
      final result = mutableMapFrom<int, String>();
      final filtered = pokemon.mapValuesTo(
          result, (entry) => "${entry.value}${entry.value.length}");
      expect(identical(result, filtered), isTrue);
      expect(
          result,
          mapFrom({
            1: "Bulbasaur9",
            2: "Ivysaur7",
          }));
    });
    test("mapValuesTo super type", () {
      final result = mutableMapFrom<num, String>();
      final filtered = pokemon.mapValuesTo(
          result, (entry) => "${entry.value}${entry.value.length}");
      expect(identical(result, filtered), isTrue);
      expect(
          result,
          mapFrom({
            1: "Bulbasaur9",
            2: "Ivysaur7",
          }));
    });
    test("mapValuesTo wrong type throws", () {
      final result = mutableMapFrom<int, int>();
      final e = catchException<ArgumentError>(() => pokemon.mapValuesTo(
          result, (entry) => "${entry.value}${entry.value.length}"));
      expect(
          e.message,
          allOf(
            contains("mapValuesTo"),
            contains("destination"),
            contains("<int, String>"),
            contains("<int, int>"),
          ));
    });
    test("mapValuesTo requires transform to be non null", () {
      const bool Function(KtMapEntry<int, String> entry) predicate = null;
      final other = mutableMapFrom<int, String>();
      final e = catchException<ArgumentError>(
          () => pokemon.mapValuesTo(other, predicate));
      expect(e.message, allOf(contains("null"), contains("transform")));
    });
    test("mapValuesTo requires destination to be non null", () {
      final e = catchException<ArgumentError>(
          () => pokemon.mapValuesTo(null, (it) => true));
      expect(e.message, allOf(contains("null"), contains("destination")));
    });
  });

  group("maxBy", () {
    test("gets max value", () {
      final map = mapFrom({"2": "Ivysaur", "1": "Bulbasaur"});
      expect(map.maxBy((it) => num.parse(it.key)).value, "Ivysaur");
    });

    test("empty iterable return null", () {
      final map = emptyMap<int, String>();
      expect(map.maxBy<num>((it) => it.key), null);
    });

    test("maxBy requires a non null selector", () {
      final e =
          catchException<ArgumentError>(() => emptyMap().maxBy<num>(null));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });
  });

  group("maxWith", () {
    int _numKeyComparison(
        KtMapEntry<num, dynamic> value, KtMapEntry<num, dynamic> other) {
      return value.key.compareTo(other.key);
    }

    test("gets max value", () {
      final map = mapFrom({2: "Ivysaur", 1: "Bulbasaur"});
      final max = map.maxWith(_numKeyComparison);
      expect(max.key, 2);
      expect(max.value, "Ivysaur");
    });

    test("empty iterable return null", () {
      final map = emptyMap<int, String>();
      expect(map.maxWith(_numKeyComparison), null);
    });

    test("maxWith requires a non null comparator", () {
      final e = catchException<ArgumentError>(
          () => emptyMap<int, String>().maxWith(null));
      expect(e.message, allOf(contains("null"), contains("comparator")));
    });
  });

  group("minus", () {
    test("remove element", () {
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map.minus(1);
      expect(result.size, 1);
      expect(result, mapFrom({2: "Ivysaur"}));
      expect(map.size, 2);
    });

    test("- (minus) operator", () {
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map - 1;
      expect(result.size, 1);
      expect(result, mapFrom({2: "Ivysaur"}));
      expect(map.size, 2);
    });

    test("-= (minusAssign) operator", () {
      var map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      map -= 1;
      expect(map.size, 1);
      expect(map, mapFrom({2: "Ivysaur"}));
    });

    test("do nothing when key doesn't exist", () {
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map.minus(5);
      expect(result, map);
    });
  });

  group("minBy", () {
    test("gets min value", () {
      final map = mapFrom({"2": "Ivysaur", "1": "Bulbasaur"});
      expect(map.minBy((it) => num.parse(it.key)).value, "Bulbasaur");
    });

    test("empty iterable return null", () {
      final map = emptyMap<int, String>();
      expect(map.minBy<num>((it) => it.key), null);
    });

    test("minBy requires a non null selector", () {
      final e =
          catchException<ArgumentError>(() => emptyMap().minBy<num>(null));
      expect(e.message, allOf(contains("null"), contains("selector")));
    });
  });

  group("minWith", () {
    int _numKeyComparison(
        KtMapEntry<num, dynamic> value, KtMapEntry<num, dynamic> other) {
      return value.key.compareTo(other.key);
    }

    test("gets min value", () {
      final map = mapFrom({2: "Ivysaur", 1: "Bulbasaur"});
      final min = map.minWith(_numKeyComparison);
      expect(min.key, 1);
      expect(min.value, "Bulbasaur");
    });

    test("empty iterable return null", () {
      final map = emptyMap<int, String>();
      expect(map.minWith(_numKeyComparison), null);
    });

    test("minWith requires a non null comparator", () {
      final e = catchException<ArgumentError>(
          () => emptyMap<int, String>().minWith(null));
      expect(e.message, allOf(contains("null"), contains("comparator")));
    });
  });

  group("plus", () {
    test("add element", () {
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map.plus(mapFrom({3: "Venusaur"}));
      expect(result.size, 3);
      expect(result[3], "Venusaur");
      expect(map.size, 2);
    });

    test("plus doesn't allow null as argument", () {
      final pokemon = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final e = catchException<ArgumentError>(() => pokemon.plus(null));
      expect(e.message, allOf(contains("null"), contains("map")));
    });

    test("+ (plus) operator", () {
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map + mapFrom({3: "Venusaur"});
      expect(result.size, 3);
      expect(result[3], "Venusaur");
      expect(map.size, 2);
    });

    test("+= (plusAssign) operator", () {
      var map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      map += mapFrom({3: "Venusaur"});
      expect(map.size, 3);
      expect(map[3], "Venusaur");
      expect(map.size, 3);
    });

    test("override existing mapping", () {
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final result = map.plus(mapFrom({2: "Dito"}));
      expect(result.size, 2);
      expect(map.size, 2);
      expect(result[2], "Dito");
      expect(map[2], "Ivysaur");
      expect(result, isNot(equals(map)));
    });
  });

  group("toList", () {
    test("makes a list which doesn't share memory", () {
      final map = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final list = map.toList();
      expect(list.size, map.size);
      map.put(3, "Venusaur");
      expect(map.size, 3);
      expect(list.size, 2);
    });

    test("make a copy of an empty map", () {
      final map = emptyMap();
      final copy = map.toList();
      expect(copy.size, map.size);
    });

    test("make a copy", () {
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final copy = map.toList();
      expect(copy,
          listOf(const KtPair(1, "Bulbasaur"), const KtPair(2, "Ivysaur")));
    });
  });

  group("toMap", () {
    test("makes a copy which doesn't share memory", () {
      final map = mutableMapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      final copy = map.toMap();
      expect(copy, map);
      map.put(3, "Venusaur");
      expect(map.size, 3);
      expect(copy.size, 2);
    });

    test("make a copy of an empty map", () {
      final map = emptyMap();
      final copy = map.toMap();
      expect(copy, map);
      expect(identical(copy, map), isFalse);
    });
  });

  group("toMutableMap", () {
    test("makes a copy", () {
      final map = mapFrom({
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

  group("forEach", () {
    test("forEach", () {
      final result = mutableListOf<String>();
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
        3: "Stegosaur",
      });
      map.forEach((number, value) => result.add("$number-$value"));
      if (ordered) {
        expect(result.size, 3);
        expect(result[0], "1-Bulbasaur");
        expect(result[1], "2-Ivysaur");
        expect(result[2], "3-Stegosaur");
      } else {
        expect(result.size, 3);
        expect(result.toSet(),
            listOf("1-Bulbasaur", "2-Ivysaur", "3-Stegosaur").toSet());
      }
    });

    test("action must be non null", () {
      final e = catchException<ArgumentError>(() => emptyMap().forEach(null));
      expect(e.message, allOf(contains("null"), contains("action")));
    });
  });

  group("none", () {
    test("none() non-empty map", () {
      final map = mapFrom({
        1: "Bulbasaur",
        2: "Ivysaur",
        3: "Stegosaur",
      });
      expect(map.none((key, value) => key == 1 && value == "Bulbasaur"), false);
      expect(map.none((_, value) => value == "Random text"), true);
    });

    test("none() empty map", () {
      final map = emptyMap();
      expect(map.none((key, value) => key == 1 && value == "Bulbasaur"), true);
      expect(map.none((key, value) => false), true);
    });

    test("predicate must be non null", () {
      final e = catchException<ArgumentError>(() => emptyMap().none(null));
      expect(e.message, allOf(contains("null"), contains("predicate")));
    });
  });
}

class ThirdPartyMap<K, V> implements KtMap<K, V> {
  ThirdPartyMap([Map<K, V> map = const {}])
      :
// copy list to prevent external modification
        _map = Map.unmodifiable(map),
        super();

  final Map<K, V> _map;
  int _hashCode;

  @override
  Iterable<KtMapEntry<K, V>> get iter =>
      _map.entries.map((entry) => _Entry.from(entry));

  @override
  Map<K, V> asMap() => _map;

  @override
  bool containsKey(K key) => _map.containsKey(key);

  @override
  bool containsValue(V value) => _map.containsValue(value);

  @override
  KtSet<KtMapEntry<K, V>> get entries =>
      setFrom(_map.entries.map((entry) => _Entry.from(entry)));

  @override
  V get(K key) => _map[key];

  @override
  V operator [](K key) => get(key);

  @override
  V getOrDefault(K key, V defaultValue) => _map[key] ?? defaultValue;

  @override
  bool isEmpty() => _map.isEmpty;

  @override
  KtSet<K> get keys => setFrom(_map.keys);

  @override
  int get size => _map.length;

  @override
  KtCollection<V> get values => listFrom(_map.values);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! KtMap) return false;
    if (other.size != size) return false;
    if (other.hashCode != hashCode) return false;
    for (final key in keys.iter) {
      if (other[key] != this[key]) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    return _hashCode ??= hashObjects(_map.keys
        .map((key) => hash2(key.hashCode, _map[key].hashCode))
        .toList(growable: false)
          ..sort());
  }
}

class _Entry<K, V> extends KtMapEntry<K, V> {
  _Entry(this.key, this.value);

  _Entry.from(MapEntry<K, V> entry)
      : key = entry.key,
        value = entry.value;
  @override
  final K key;

  @override
  final V value;

  @override
  KtPair<K, V> toPair() => KtPair(key, value);
}
