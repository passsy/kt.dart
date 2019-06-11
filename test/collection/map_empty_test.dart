import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group("mapFrom", () {
    testMap(<K, V>() => emptyMap<K, V>(), mutable: false);
  });
  group("KtMap.from", () {
    testMap(<K, V>() => KtMap<K, V>.from(), mutable: false);
  });
  group("KtMap.empty", () {
    testMap(<K, V>() => KtMap<K, V>.empty(), mutable: false);
  });
  group("mutableMapFrom", () {
    testMap(<K, V>() => mutableMapFrom<K, V>());
  });
  group("KtMutableMap.empty", () {
    testMap(<K, V>() => KtMutableMap<K, V>.empty());
  });
  group("KtMutableMap.from", () {
    testMap(<K, V>() => KtMutableMap<K, V>.from());
  });
  group("hashMapFrom", () {
    testMap(<K, V>() => hashMapFrom<K, V>());
  });
  group("KHashMap.empty", () {
    testMap(<K, V>() => KtHashMap<K, V>.empty());
  });
  group("KHashMap.from", () {
    testMap(<K, V>() => KtHashMap<K, V>.from());
  });
  group("linkedMapFrom", () {
    testMap(<K, V>() => linkedMapFrom<K, V>());
  });
  group("KLinkedMap.empty", () {
    testMap(<K, V>() => KtLinkedMap<K, V>.empty());
  });
  group("KLinkedMap.from", () {
    testMap(<K, V>() => KtLinkedMap<K, V>.from());
  });
}

void testMap(KtMap<K, V> Function<K, V>() emptyMap, {bool mutable = true}) {
  group('empty map', () {
    test("has no elements", () {
      final empty = emptyMap<String, Object>();
      expect(empty.size, equals(0));
    });

    test("contains nothing", () {
      expect(emptyMap<String, String>().containsKey("asdf"), isFalse);
      expect(emptyMap<String, String>().containsValue("asdf"), isFalse);
      expect(emptyMap<int, int>().containsKey(null), isFalse);
      expect(emptyMap<int, int>().containsValue(null), isFalse);
      expect(emptyMap<int, int>().containsKey(0), isFalse);
      expect(emptyMap<int, int>().containsValue(0), isFalse);
      expect(emptyMap<List, List>().containsKey([]), isFalse);
      expect(emptyMap<List, List>().containsValue([]), isFalse);
    });

    test("values iterator has no next", () {
      final empty = emptyMap();
      expect(empty.values.iterator().hasNext(), isFalse);
      expect(() => empty.values.iterator().next(),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("keys iterator has no next", () {
      final empty = emptyMap();
      expect(empty.keys.iterator().hasNext(), isFalse);
      expect(() => empty.keys.iterator().next(),
          throwsA(const TypeMatcher<NoSuchElementException>()));
    });

    test("is empty", () {
      final empty = emptyMap<String, Object>();

      expect(empty.isEmpty(), isTrue);
    });

    test("get always returns null", () {
      final empty = emptyMap();

      expect(empty.get(0), isNull);
      expect(empty.get(1), isNull);
      expect(empty.get(-1), isNull);
      expect(empty.get(null), isNull);
    });
    test("[] operator always returns null", () {
      final empty = emptyMap();

      expect(empty[0], isNull);
      expect(empty[1], isNull);
      expect(empty[-1], isNull);
      expect(empty[null], isNull);
    });

    test("is equals to another empty map", () {
      final empty0 = emptyMap();
      final empty1 = emptyMap();

      expect(empty0, equals(empty1));
      expect(empty0.hashCode, equals(empty1.hashCode));
    });

    test("empty lists of different type are equal", () {
      final empty0 = emptyMap<int, String>();
      final empty1 = emptyMap<String, Object>();

      expect(empty0, equals(empty1));
      expect(empty0.hashCode, equals(empty1.hashCode));
    });

    test("is same as empty mutable map", () {
      final empty0 = emptyMap<int, String>();
      final empty1 = mutableMapFrom();

      expect(empty0, equals(empty1));
      expect(empty0.hashCode, equals(empty1.hashCode));
    });

    test("asMap has zero length", () {
      final Map<String, int> map = emptyMap<String, int>().asMap();
      expect(map.length, 0);
    });
    if (mutable) {
      test("asMap is mutable", () {
        final Map<String, int> map = emptyMap<String, int>().asMap();
        map["a"] = 1;
        expect(map["a"], 1);
      });
    } else {
      test("asMap is immutable", () {
        final Map<String, int> map = emptyMap<String, int>().asMap();
        final e = catchException<UnsupportedError>(() => map["a"] = 1);
        expect(e.message, contains("unmodifiable"));
      });
    }
    test("containsKeyalways returns false", () {
      expect(emptyMap().containsKey(2), isFalse);
      expect(emptyMap().containsKey(null), isFalse);
      expect(emptyMap().containsKey(""), isFalse);
    });
    test("containsValuealways returns false", () {
      expect(emptyMap().containsValue(2), isFalse);
      expect(emptyMap().containsValue(null), isFalse);
      expect(emptyMap().containsValue(""), isFalse);
    });
    test("getOrDefault always returns the default", () {
      expect(emptyMap().getOrDefault(0, "Ditto"), equals("Ditto"));
    });
    test("isEmpty always returns true", () {
      expect(mapFrom().isEmpty(), isTrue);
    });
    test("values always is empty", () {
      expect(emptyMap().values.isEmpty(), isTrue);
    });
    test("entries always is empty", () {
      expect(emptyMap().entries.isEmpty(), isTrue);
    });

    test("iter via for loop", () {
      final pokemon = emptyMap();

      final values = mutableListOf();
      final keys = mutableListOf();
      for (final p in pokemon.iter) {
        keys.add(p.key);
        values.add(p.value);
      }
      expect(values.isEmpty(), isTrue);
      expect(keys.isEmpty(), isTrue);
    });
  });
}
