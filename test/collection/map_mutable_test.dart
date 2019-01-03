import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group("_MutableEntry", () {
    test("entries can be converted to pairs", () {
      final pokemon = mutableMapOf({
        1: "Bulbasaur",
        2: "Ivysaur",
      });
      expect(pokemon.entries.map((it) => it.toPair()),
          listOf(KPair(1, "Bulbasaur"), KPair(2, "Ivysaur")));
    });

    test("set value for mutable entry", () {
      final pokemon = mutableMapOf({
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
      //     mapOf({
      //       1: "BULBASAUR",
      //      2: "IVYSAUR",
      //    }));
    });
  });
}
