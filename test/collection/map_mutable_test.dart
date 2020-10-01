import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group('KtMutableMap', () {
    group('mutableMapFrom', () {
      testMutableMap(<K, V>(Map<K, V> map) => mutableMapFrom<K, V>(map));
    });
    group('KtMutableMap.from', () {
      testMutableMap(<K, V>(Map<K, V> map) => KtMutableMap<K, V>.from(map));
    });
    group('hashMapFrom', () {
      testMutableMap(<K, V>(Map<K, V> map) => hashMapFrom<K, V>(map),
          ordered: false);
    });
    group('KtHashMap', () {
      testMutableMap(<K, V>(Map<K, V> map) => KtHashMap<K, V>.from(map),
          ordered: false);
    });
    group('linkedMapFrom', () {
      testMutableMap(<K, V>(Map<K, V> map) => linkedMapFrom<K, V>(map));
    });
    group('KtLinkedMap', () {
      testMutableMap(<K, V>(Map<K, V> map) => KtLinkedMap<K, V>.from(map));
    });
  });
}

void testMutableMap(
    KtMutableMap<K, V> Function<K, V>(Map<K, V> map) mutableMapFrom,
    {bool ordered = true}) {
  group('add item', () {
    test('add item', () {
      final pokemon = mutableMapFrom({
        1: 'Bulbasaur',
        2: 'Ivysaur',
      });
      expect(pokemon.put(3, 'Venusaur'), null);
      expect(pokemon.size, 3);
    });
    test('override item', () {
      final pokemon = mutableMapFrom({
        1: 'Bulbasaur',
        2: 'Ivysaur',
      });
      expect(pokemon.put(2, 'Ditto'), 'Ivysaur');
      expect(pokemon.size, 2);
    });
  });
  group('remove item', () {
    test('remove item', () {
      final pokemon = mutableMapFrom({
        1: 'Bulbasaur',
        2: 'Ivysaur',
      });
      expect(pokemon.remove(2), 'Ivysaur');
      expect(pokemon.size, 1);
    });
  });

  group('_MutableEntry', () {
    test('entries can be converted to pairs', () {
      final pokemon = mutableMapFrom({
        1: 'Bulbasaur',
        2: 'Ivysaur',
      });
      expect(pokemon.entries.map((it) => it.toPair()),
          listOf(const KtPair(1, 'Bulbasaur'), const KtPair(2, 'Ivysaur')));
    });

    test('set value for mutable entry', () {
      final pokemon = mutableMapFrom({
        1: 'Bulbasaur',
        2: 'Ivysaur',
      });

      final e = catchException(() {
        pokemon.entries.forEach((entry) {
          entry.setValue(entry.value.toUpperCase());
        });
      });

      // TODO exchange error check with assertion once https://github.com/passsy/dart_kollection/issues/55 has been fixed
      expect(e, const TypeMatcher<UnimplementedError>());
      // expect(
      //    pokemon,
      //     mapFrom({
      //       1: 'BULBASAUR',
      //      2: 'IVYSAUR',
      //    }));
    });
  });
}
