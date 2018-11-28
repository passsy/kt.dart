# Dart Kollection

Brings Kotlins collection API to Dart with over 120+ operators which makes it easier to work with `Lists`, `Maps` and `Sets`.
The collections are by default immutable, but they all have a mutable version as well.


## Get started

```dart
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
```

## Motivation

Dart already has a great API for collections. But `List` in dart has some disadvantages compared to a `List` in Kotlin which this problems tries to solve. In a nutshell Darts `List` is better comparable to Kotlins `Array`:
- Darts `List` quals only compares identities, not the content of the `List` which is hard to understand for newcomers.
- Darts `List` is mutable by default, offering mutation methods even for immutable lists which crash at runtime. Those errors could be easily preventable with correct types.
- Darts `Iterable` methods are uncommon. Most languages support `flatMap` and `filter` whereas dart offers `expand` and `where`. 

Also Darts `Iterable` methods aren't extendable. 
The only solution to bring kotlins cool operators to Dart is to create my own collections.
The dart team is already working on [extension functions](https://github.com/dart-lang/language/issues/41).
Until they're ready I already wanted to have dart code ready to be ported to extension functions.

But even when dart will support extension functions, this project offers a high level collection API which currently do not exist in Dart. 
When Dart `List` is the counterpart to Kotlins `Array`, Kollections `KList` is the counterpart to Kotlins `List`.

## Supported Types

Supported types:
- `KList`
- `KMutableList`
- `KSet`
- `KMutableSet`
- `KMap`
- `KMutableMap`

Additionally Kollection offers `KIterable` and `KCollection` and their mutable counterparts but those are mostly used internally.


## License

```
Copyright 2018 Pascal Welsch

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
