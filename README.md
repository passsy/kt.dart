# kt.dart

[![Pub](https://img.shields.io/pub/v/kt_dart.svg)](https://pub.dartlang.org/packages/kt_dart)
[![codecov](https://codecov.io/gh/passsy/kt.dart/branch/master/graph/badge.svg)](https://codecov.io/gh/passsy/kt.dart)

<p align="center">
  <img src="https://user-images.githubusercontent.com/1096485/51038827-6e47b300-15b4-11e9-8618-da9f2af61738.png">
</p>

This project is a port of Kotlin's [Kotlin Standard library](https://kotlinlang.org/api/latest/jvm/stdlib/index.html) for Dart/Flutter projects. It's a useful addition to [`dart:core`](https://api.dartlang.org/stable/dart-core/dart-core-library.html) and includes collections (`KtList`, `KtMap`, `KtSet`) as well as other packages which can improve every Dart/Flutter app. 

```yaml
dependencies: 
  kt_dart: ^0.10.0
```

```dart
import 'package:kt_dart/kt.dart';
```


## Motivation

Dart's [`dart:core`](https://api.dartlang.org/stable/dart-core/dart-core-library.html) package provides basic building blocks. But sometimes they are too low level and not as straightforward as Kotlin's [`kotlin-stdlib`](https://kotlinlang.org/api/latest/jvm/stdlib/index.html).

Here are a few examples of what this project offers: _(click to expand)_

<details>
  <summary>Immutable collections by default</summary>

### `dart:core` collections

Dart's `List` is mutable by default. The immutable `List.unmodifiable` is the same type, but the mutation methods throw at runtime.

```dart
final dartList = [1, 2, 3];
dartList.add(4); // mutation is by default possible
assert(dartList.length == 4);

final immutableDartList = List.unmodifiable(dartList);
immutableDartList.add(5); // throws: Unsupported operation: Cannot add to an unmodifiable list
```

Dart's mutable `List` is indistinguishable from an immutable `List` which might cause errors.
```dart
void addDevice(List<Widget> widgets, Device device) {
  // no way to check whether widgets is mutable or not
  // add might or might now throw
  widgets.add(_deviceRow());
  widgets.add(Divider(height: 1.0));
}
```

### `kt_dart` collections

`KtList` and `KtMutableList` are two different Types. `KtList` is immutable by default and has no mutation methods (such as `add`). Methods like `map((T)->R)` or `plusElement(T)` return a new `KtList` leaving the old one unmodified.
```dart
final ktList = listOf(1, 2, 3);
// The method 'add' isn't defined for the class 'KtList<int>'.
ktList.add(4); // compilation error
       ^^^

// Adding an item returns a new KtList
final mutatedList = ktList.plusElement(4);
assert(ktList.size == 3);
assert(mutatedList.size == 4);
```

`KtMutableList` offers mutation methods where the content of that collection can be actually mutated.
I.e. with `remove(T)` or `add(T)`; 
```dart
// KtMutableList allow mutation
final mutableKtList = mutableListOf(1, 2, 3);
mutableKtList.add(4); // works!
assert(mutableKtList.size == 4);
```

All collection types have mutable counterparts:

|Immutable|Mutable|
|---|---|
|`KtList` | `KtMutableList` |
|`KtSet` | `KtMutableSet`, `KtHashSet`, `KtLinkedSet` |
|`KtMap` | `KtMutableMap`, `KtHashMap`, `KtLinkedMap` |
|`KtCollection` | `KtMutableCollection` and all the above |
|`KtIterable` | `KtMutableIterable` and all the above |
  
</details>

<details>
  <summary>Deep equals</summary>

### `dart:core` collections

Dart's `List` works like a `Array` in Java. `Equals` doesn't compare the items; it only checks the identity.
To compare the contents you have to use helper methods methods from `'package:collection/collection.dart'`.

```dart
// Comparing two Dart Lists works only by identity
final a = [1, 2, 3, 4];
final b = [1, 2, 3, 4];
print(a == b); // false, huh?

// Content-based comparisons require unnecessary glue code
Function listEq = const ListEquality().equals;
print(listEq(a, b)); // true

// MapEquality isn't deep by default
final x = {1: ["a", "b", "c"], 2: ["xx", "yy", "zz"]};
final y = {1: ["a", "b", "c"], 2: ["xx", "yy", "zz"]};
Function mapEq = const MapEquality().equals;
print(mapEq(x, y)); // false, wtf?!

Function deepEq = const DeepCollectionEquality().equals;
print(deepEq(x, y)); // true, finally
```

### `kt_dart` collections

`KtList` and all other collection types implement `equals` by deeply comparing all items.

```dart
final a = listOf(1, 2, 3, 4);
final b = listOf(1, 2, 3, 4);
print(a == b); // true, as expected

final x = mapFrom({1: listOf("a", "b", "c"), 2: listOf("xx", "yy", "zz")});
final y = mapFrom({1: listOf("a", "b", "c"), 2: listOf("xx", "yy", "zz")});
print(x == y); // deep equals by default
```
</details>

<details>
  <summary>Common methods</summary>

Some of Dart's method names feel unfamiliar. That's because modern languages and frameworks (Kotlin, Swift, TypeScript, ReactiveExtensions) kind of agreed on naming methods when it comes to collections. This makes it easy to switch platforms and discuss implementations with coworkers working with a different language.

### expand -> flatMap
```dart
final dList = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
final kList = listOf(listOf(1, 2, 3), listOf(4, 5, 6), listOf(7, 8, 9));

// dart:core
final dFlat = dList.expand((l) => l).toList();
print(dFlat); // [1, 2, 3, 4, 5, 6, 7, 8, 9]

// kt_dart
final kFlat = kList.flatMap((l) => l);
print(kFlat); // [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

### where -> filter
```dart
final dNames = ["Chet", "Tor", "Romain", "Jake", "Dianne"];
final kNames = listFrom(dNames);

// dart:core
final dShortNames = dNames.where((name) => name.length <= 4).toList();
print(dShortNames); // [Chet, Tor, Jake]

// kt_dart
final kShortNames = kNames.filter((name) => name.length <= 4);
print(kShortNames); // [Chet, Tor, Jake]
```

### firstWhere -> first, firstOrNull
```dart
final dNames = ["Chet", "Tor", "Romain", "Jake", "Dianne"];
final kNames = listFrom(dNames);

// dart:core
dNames.firstWhere((name) => name.contains("k")); // Jake
dNames.firstWhere((name) => name.contains("x"), orElse: () => null); // null
dNames.firstWhere((name) => name.contains("x"), orElse: () => "Nobody"); // Nobody

// kt_dart
kNames.first((name) => name.contains("k")); // Jake
kNames.firstOrNull((name) => name.contains("x")); // null
kNames.firstOrNull((name) => name.contains("x")) ?? "Nobody"; // Nobody
```
</details>

## KtList

`KtList` is a read-only list of elements. It is immutable because it doesn't offer mutation methods such as `remove` or `add`.
Use `KtMutableMap` if you want to use a mutable list. 

To create a `KtList`/`KtMutableList` use the `KtList.of` constructor or convert an existing Dart `List` to a `KtList` with the `list.toImmutableList()` extension.

### Create a KtList

```dart
// Create a KtList from scratch
final beatles = KtList.of("John", "Paul", "George", "Ringo");

// Convert a existing List to KtList
final abba = ["Agnetha", "Björn", "Benny", "Anni-Frid"];
final immutableAbba = abba.toImmutableList();
```

### Create a KtMutableList

`KtList` is immutable by default, which means it doesn't offer methods like `add` or `remove`.
 To create mutable list with **kt_dart** use the `KtMutableList` constructor.
```dart
// Create a KtMutableList from scratch
final beatles = KtMutableList.of("John", "Paul", "George", "Ringo");
beatles.removeAt(0);
print(beatles); // [Paul, George, Ringo]
```

### Mutable/Immutable conversion

Conversions between `KtList` and `KtMutableList` can be done with `KtList.toMutableList()` and `KtMutableList.toList()`;

```dart
final beatles = KtList.of("John", "Paul", "George", "Ringo");
final mutable = beatles.toMutableList();
mutable.removeAt(0);
print(mutable); // [Paul, George, Ringo]
print(beatles); // [John, Paul, George, Ringo]
```

### for loop

**kt_dart** collections do not implement `Iterable`.
It is therefore not possible to directly iterate over the entries of a `KtList`.

All **kt_dart** collections offer a `.iter` property which exposes a Dart `Iterable`.
For-loops therefore don't look much different.

```dart
final beatles = KtList.of("John", "Paul", "George", "Ringo");
for (final member in beatles.iter) {
  print(member);
}
```

Yes, alternatively you could use `.asList()` instead which returns a Dart `List`.

### Kotlin syntax
Kotlin users might be more familiar with the `listOf()` and `mutableListOf()` functions.
Use them if you like but keep in mind that the dart community is much more used to use constructors instead of top-level functions.

```dart
final beatles = listOf("John", "Paul", "George", "Ringo");
final abba = mutableListOf("Agnetha", "Björn", "Benny", "Anni-Frid");
```


## KtSet

A `KtSet` is a unordered collection of elements without duplicates.

Creating a `KtSet`/`KtMutableSet` is very similar to the `KtList` API. 

```dart
// Create a KtSet from scratch
final beatles = KtSet.of("John", "Paul", "George", "Ringo");

// Convert a existing Set to KtSet
final abba = {"Agnetha", "Björn", "Benny", "Anni-Frid"};
final immutableAbba = abba.toImmutableSet();
```

## KtMap

To create a `KtMap`/`KtMutableMap` start with Dart `Map` and then convert it to a `KtMap` with either:
- `pokemon.toImmutableMap(): KtMap` (since Dart 2.7)
- `KtMap.from(pokemon): KtMap`
- `pokemon.kt: KtMutableMap` (since Dart 2.7)
- `KtMutableMap.from(pokemon): KtMutableMap`

```dart
// immutable
final pokemon = {
  1: "Bulbasaur",
  2: "Ivysaur",
  3: "Stegosaur",
}.toImmutableMap();

final newPokemon = KtMap.from({
  152: "Chikorita",
  153: "Bayleef",
  154: "Meganium",
});

// mutable
final mutablePokemon = {
  1: "Bulbasaur",
  2: "Ivysaur",
  3: "Stegosaur",
}.kt;

final newMutablePokemon = KtMutableMap.from({
  152: "Chikorita",
  153: "Bayleef",
  154: "Meganium",
});
```

### KtHashMap and KtLinkedMap

You may want to use a specific `Map` implementation. **kt_dart** offers:
 - `KtLinkedMap` - based on Darts `LinkedHashMap` where the insertion order of keys is remembered and keys are iterated in the order they were inserted into the map
- `KtHashMap` - based on Darts `HashMap` where keys of a `HashMap` must have consistent \[Object.==\] and \[Object.hashCode\] implementations. Iterating the map's keys, values or entries (through \[forEach\]) may happen in any order.

## KtPair, KtTriple

**kt_dart** offer two types of tuples, `KtPair` with two elements and `KtTriple` with three elements.
They are used by some collection APIs and prevent a 3rd party dependency. 

```dart
final beatles = KtList.of("John", "Paul", "George", "Ringo");
final partitions = beatles.partition((it) => it.contains("n"));
print(partitions.first); // [John, Ringo]
print(partitions.second); // [Paul, George]
```

There won't be a `KtQuadruple` or `TupleN` in this library.
If you want to use tuples heavily in you application consider using the [`tuple`](https://pub.dev/packages/tuple) package.
Better, use [`freezed`](https://github.com/rrousselGit/freezed) to generated data classes which makes for a much better API.

## Annotations

### `@nullable`

Kotlin already has Non-Nullable types, something which is coming to Dart soon™.
**kt_dart** already makes use of Non-Nullable Types and never returns `null` unless a method is annotated with `@nullable`.

https://github.com/passsy/kt.dart/blob/490a3b205ffef27d9865d6018381a4168119e69f/lib/src/collection/kt_map.dart#L51-L53

There isn't any tooling which will warn you about the wrong usage but at least it's documented.
And once nnbd lands in Dart it will be fairly easy to convert.

### `@nonNull`

This annotation annotates methods which never return `null`.
Although this is the default in **kt_dart**, is makes it very obvious for methods which sometimes return `null` in other languages.

### `@experimental`

A method/class annotated with `@experimental` marks the method/class as experimental feature. Experimental APIs can be changed or removed at any time.

## License

```
Copyright 2019 Pascal Welsch

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
