# Dart Kollection

[![Pub](https://img.shields.io/pub/v/dart_kollection.svg)](https://pub.dartlang.org/packages/dart_kollection)


Brings Kotlin's collections implementation to Dart with over 120+ operators which makes it easier to work with `Lists`, `Maps` and `Sets`.
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

  final kMapEquals = mapFrom({1: "Bulbasaur", 2: "Ivysaur"}) == mapFrom({1: "Bulbasaur", 2: "Ivysaur"});
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
  final pokemon = mutableMapFrom({
    1: "Bulbasaur",
    2: "Ivysaur",
  });
  pokemon[1] = "Ditto";
  print(pokemon); // {1=Ditto, 2=Ivysaur}

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

Although Dart already has a great implementation for collections, its `List` has some disadvantages compared to a `List` in Kotlin which this package tries to solve. In a nutshell, Dart's `List` is better comparable to Kotlin's `Array`:
- Dart's `List.equals` only compares identities, not the content of the `List` which is hard to understand for newcomers.
- Dart's `List` is mutable by default, offering mutation methods even for immutable lists which crash at runtime. Those errors could easily be prevented with correct types.
- Dart's `Iterable` methods are uncommon. Most languages support `flatMap` and `filter` whereas Dart offers `expand` and `where`. 

Also Darts `Iterable` methods aren't extendable. 
The only solution to bring kotlins cool operators to Dart is to create my own collections.
The dart team is already working on [extension functions](https://github.com/dart-lang/language/issues/41).
Until they're ready I already wanted to have dart code ready to be ported to extension functions.

But even when dart will support extension functions, this project offers a high level collection API which currently do not exist in Dart. 
Where Dart's `List` is the counterpart to Kotlin's `Array`, Kollections' `KList` is the counterpart to Kotlin's `List`.

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
