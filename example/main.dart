// ignore_for_file: avoid_print
import 'package:kt_dart/kt.dart';

void main() {
  /// Lists
  final mapped = listOf(1, 2, 3, 4).map((it) => '>$it<');
  print(mapped); // [>1<, >2<, >3<, >4<]

  final flatMapped = listOf(1, 2, 3, 4).flatMap((it) => listOf(it * 2, it * 3));
  print(flatMapped); // [2, 3, 4, 6, 6, 9, 8, 12]

  final filtered = flatMapped.filter((it) => it % 3 == 0);
  print(filtered); // [3, 6, 6, 9, 12]

  final distinct = listFrom([1, 2, 3, 1, 2, 3]).distinct();
  print(distinct); //[1, 2, 3]

  /// Better equals
  final kListEquals = listOf(12, 9, 6, 3) == listOf(12, 9, 6, 3);
  print(kListEquals); // true

  final dartListEquals = [12, 9, 6, 3] == [12, 9, 6, 3];
  print(dartListEquals); // false

  final kMapEquals = mapFrom({1: 'Bulbasaur', 2: 'Ivysaur'}) ==
      mapFrom({1: 'Bulbasaur', 2: 'Ivysaur'});
  print(kMapEquals); // true

  final dartMapEquals =
      {1: 'Bulbasaur', 2: 'Ivysaur'} == {1: 'Bulbasaur', 2: 'Ivysaur'};
  print(dartMapEquals); // false

  /// Sets
  print(setOf(1, 2, 3, 1, 2, 3)); // [1, 2, 3]

  /// Maps
  final pokemon = mutableMapFrom({
    1: 'Bulbasaur',
    2: 'Ivysaur',
  });
  pokemon[1] = 'Ditto';
  print(pokemon); // {1=Ditto, 2=Ivysaur}

  /// Tons of useful operators which *should* be part of the dart std lib
  final numbers = listOf(1, 2, 3, 4);
  print(numbers.sum()); // 10

  final numbers5 = listOf(1, 2, 3, 4).sortedDescending();
  print(numbers5); // [4, 3, 2, 1]

  final beatles = setOf('John', 'Paul', 'George', 'Ringo');
  print(beatles); // [John, Paul, George, Ringo]
  print(beatles.joinToString(
      separator: '/',
      transform: (it) => it.toUpperCase())); // JOHN/PAUL/GEORGE/RINGO

  final grouped = beatles.groupBy((it) => it.length);
  print(grouped); // {4=[John, Paul], 6=[George], 5=[Ringo]}
}
