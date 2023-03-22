import "package:kt_dart/collection.dart";
import "package:test/test.dart";

void main() {
  group("KtMutableSetExtensions", () {
    group("mutableSet", () {
      testSet(<T>() => KtMutableSet.empty(), mutableSetOf, mutableSetFrom);
    });
    group("hashSet", () {
      testSet(<T>() => KtHashSet.empty(), hashSetOf, hashSetFrom);
    });
    group("linkedSet", () {
      testSet(<T>() => KtLinkedSet.empty(), linkedSetOf, linkedSetFrom);
    });
  });
}

void testSet(
  KtMutableSet<T> Function<T>() emptySet,
  KtMutableSet<T> Function<T>(
          [T arg0,
          T arg1,
          T arg2,
          T arg3,
          T arg4,
          T arg5,
          T arg6,
          T arg7,
          T arg8,
          T arg9])
      mutableSetOf,
  KtMutableSet<T> Function<T>([Iterable<T> iterable]) mutableSetFrom,
) {
  group("dart property", () {
    test("dart property returns an empty list", () {
      final dartList = emptySet<int>().dart;
      expect(dartList.length, 0);
    });

    test("dart property returns an modifiable list", () {
      final original = mutableSetOf<int>();
      final dartList = original.dart;
      dartList.add(1);
      expect(original, mutableSetOf(1));
      expect(dartList, {1});
    });
  });

  test("remove item from ser via iterator", () {
    final pokemon = mutableSetOf(
      "Bulbasaur",
      "Ivysaur",
    );
    final iterator = pokemon.iterator();
    expect(iterator.hasNext(), isTrue);
    final next = iterator.next();
    iterator.remove();

    // order is unknown, catch both cases
    if (next == "Bulbasaur") {
      expect(pokemon, setOf("Ivysaur"));
    } else {
      expect(pokemon, setOf("Bulbasaur"));
    }
  });

  test("remove() handles null value", () {
    final pokemon = mutableSetOf(
      null,
      "Bulbasaur",
      "Ivysaur",
    );
    final KtMutableIterator<String?> i = pokemon.iterator();
    while (i.hasNext()) {
      final next = i.next();
      if (next == null) {
        // remove null
        i.remove();
        break;
      }
    }
    expect(pokemon, setOf("Bulbasaur", "Ivysaur"));
  });
}
