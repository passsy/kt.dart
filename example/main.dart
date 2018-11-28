import 'package:dart_kollection/dart_kollection.dart';

main() {
  /**
   * Lists
   */
  final numbers1 = listOf([1, 2, 3, 4]).map((it) => ">$it<");
  print(numbers1); // [>1<, >2<, >3<, >4<]

  final numbers2 = listOf([1, 2, 3, 4]).flatMap((it) => listOf([it * 2, it * 3]));
  print(numbers2); // [2, 3, 4, 6, 6, 9, 8, 12]

  final numbers3 = numbers2.filter((it) => it % 3 == 0);
  print(numbers3); // [3, 6, 6, 9, 12]

  final numbers4 = numbers3.distinct();
  print(numbers4); //[3, 6, 9, 12]

  /**
   * Better equals
   */
  final klistEquals = listOf([12, 9, 6, 3]) == listOf([12, 9, 6, 3]);
  print(klistEquals); // true

  final dartListEquals = [12, 9, 6, 3] == [12, 9, 6, 3];
  print(dartListEquals); // false

  final kMapEquals = mapOf({1: "Bulbasaur", 2: "Ivysaur"}) == mapOf({1: "Bulbasaur", 2: "Ivysaur"});
  print(kMapEquals); // true

  final dartMapEquals = {1: "Bulbasaur", 2: "Ivysaur"} == {1: "Bulbasaur", 2: "Ivysaur"};
  print(dartMapEquals); // false

  /**
   * Sets
   */
  print(setOf([1, 1, 2, 2, 3])); // [1, 2, 3]

  /**
   * Maps
   */
  final pokemon = mutableMapOf({
    1: "Bulbasaur",
    2: "Ivysaur",
  });
  pokemon[1] = "Dito";
  print(pokemon); // {1=Dito, 2=Ivysaur}

  /**
   * Tons of useful operators which *should* be part of the dart std lib
   */
  final numbers = listOf([1, 2, 3, 4]);
  print(numbers.sum()); // 10

  final numbers5 = listOf([1, 2, 3, 4]).sortedDescending();
  print(numbers5); // [4, 3, 2, 1]

  final beatles = setOf(["John", "Paul", "George", "Ringo"]);
  print(beatles); // [John, Paul, George, Ringo]
  print(beatles.joinToString(separator: "/")); // John/Paul/George/Ringo
}
