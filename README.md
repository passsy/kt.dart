# Dart Kollection

[![Pub](https://img.shields.io/pub/v/dart_kollection.svg)](https://pub.dartlang.org/packages/dart_kollection)

A collection library for Dart with over 150 methods to work with `List`, `Map` and `Set`.
The collections are immutable by default but offer a mutable counterpart.

This library is heavily inspired by Kotlins collection API.

Kollections `KList` is to Dart's `List` what Kotlins `List` is to Javas `Array`.

## Motivation

Although Dart already has a great implementation for collections, its `List` has some disadvantages compared to a `List` in Kotlin which this package tries to solve. In a nutshell, Dart's `List` is better comparable to Kotlin's `Array`:
- Dart's `List.equals` only compares identities, not the content of the `List` which is hard to understand for newcomers.
- Dart's `List` is mutable by default, offering mutation methods even for immutable lists which crash at runtime. Those errors could easily be prevented with correct types.
- Dart's `Iterable` methods are uncommon. Most languages support `flatMap` and `filter` whereas Dart offers `expand` and `where`. 


## Get started

### Create collections with Kollection

Kollection offers two types of APIs to create collections. Via top level functions (Kotlin like) or with constructors (dart like).
Both APIs are equally supported, neither is preferred.

Both APIs allow creation of collections with `of` or wrapping existing Dart `Iterable` with `from`.

#### Kotlin like function based syntax
```dart
  /// List
  // Create immutable lists
  emptyList<int>();
  listOf(1, 2, 3, 4, 5);
  listFrom([1, 2, 3, 4, 5]);

  // Create mutable lists
  mutableListOf(1, 2, 3, 4, 5);
  mutableListFrom([1, 2, 3, 4, 5]);

  /// Set
  // Create immutable sets
  emptySet<int>();
  setOf(1, 2, 3, 4, 5);
  setFrom([1, 2, 3, 4, 5]);

  // Create a mutable set which keeps the order of the items
  linkedSetOf(1, 2, 3, 4, 5);
  linkedSetFrom([1, 2, 3, 4, 5]);

  // Create mutable, unordered hash-table based set
  hashSetOf(1, 2, 3, 4, 5);
  hashSetFrom([1, 2, 3, 4, 5]);

  /// Map
  // Create immutable maps
  emptyMap<int, String>();
  mapFrom({1: "a", 2: "b"});

  // Create mutable maps
  mutableMapFrom({1: "a", 2: "b"});

  // Create mutable maps without specified order when iterating over items
  hashMapFrom({1: "a", 2: "b"});

  // Create mutable maps which keep the order of the items
  linkedMapFrom({1: "a", 2: "b"});
```

#### Dart like, constructor based syntax
```dart
  /// List
  // Create immutable lists
  KList<int>.empty();
  KList.of(1, 2, 3, 4, 5);
  KList.from([1, 2, 3, 4, 5]);

  // Create mutable lists
  KMutableList<int>.empty();
  KMutableList.of(1, 2, 3, 4, 5);
  KMutableList.from([1, 2, 3, 4, 5]);

  /// Set
  // Create immutable sets
  KSet<int>.empty();
  KSet.of(1, 2, 3, 4, 5);
  KSet.from([1, 2, 3, 4, 5]);

  // Create a mutable set which keeps the order of the items
  KMutableSet<int>.empty();
  KMutableSet.of(1, 2, 3, 4, 5);
  KMutableSet.from([1, 2, 3, 4, 5]);

  // Create mutable, unordered hash-table based set
  KHashSet<int>.empty();
  KHashSet.of(1, 2, 3, 4, 5);
  KHashSet.from([1, 2, 3, 4, 5]);

  // Create a mutable set which keeps the order of the items
  KLinkedSet<int>.empty();
  KLinkedSet.of(1, 2, 3, 4, 5);
  KLinkedSet.from([1, 2, 3, 4, 5]);

  /// Map
  // Create mutable maps
  KMutableMap<int, String>.empty();
  KMutableMap.from({1: "a", 2: "b"});

  // Create mutable maps without specified order when iterating over items
  KHashMap<int, String>.empty();
  KHashMap.from({1: "a", 2: "b"});

  // Create mutable maps which keep the order of the items
  KLinkedMap<int, String>.empty();
  KLinkedMap.from({1: "a", 2: "b"});
```

### Example: Working with the collections API

```dart
import 'package:dart_kollection/dart_kollection.dart';

void main() {
    /**
     * Lists
     */
    final mapped = listOf(1, 2, 3, 4).map((it) => ">$it<");
    print(mapped); // [>1<, >2<, >3<, >4<]
    
    final flatMapped = listOf(1, 2, 3, 4).flatMap((it) => listOf(it * 2, it * 3));
    print(flatMapped); // [2, 3, 4, 6, 6, 9, 8, 12]
    
    final filtered = flatMapped.filter((it) => it % 3 == 0);
    print(filtered); // [3, 6, 6, 9, 12]
    
    final distinct = listFrom([1, 2, 3, 1, 2, 3]).distinct();
    print(distinct); //[1, 2, 3]
    
    /**
     * Better equals
     */
    final kListEquals = listOf(12, 9, 6, 3) == listOf(12, 9, 6, 3);
    print(kListEquals); // true
    
    final dartListEquals = [12, 9, 6, 3] == [12, 9, 6, 3];
    print(dartListEquals); // false
    
    final kMapEquals = mapFrom({1: "Bulbasaur", 2: "Ivysaur"}) ==
     mapFrom({1: "Bulbasaur", 2: "Ivysaur"});
    print(kMapEquals); // true
    
    final dartMapEquals =
     {1: "Bulbasaur", 2: "Ivysaur"} == {1: "Bulbasaur", 2: "Ivysaur"};
    print(dartMapEquals); // false
    
    /**
     * Sets
     */
    print(setOf(1, 2, 3, 1, 2, 3)); // [1, 2, 3]
    
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
    final numbers = listOf(1, 2, 3, 4);
    print(numbers.sum()); // 10
    
    final numbers5 = listOf(1, 2, 3, 4).sortedDescending();
    print(numbers5); // [4, 3, 2, 1]
    
    final beatles = setOf("John", "Paul", "George", "Ringo");
    print(beatles); // [John, Paul, George, Ringo]
    print(beatles.joinToString(
     separator: "/",
     transform: (it) => it.toUpperCase())); // JOHN/PAUL/GEORGE/RINGO
    
    final grouped = beatles.groupBy((it) => it.length);
    print(grouped); // {4=[John, Paul], 6=[George], 5=[Ringo]}
}
```

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
