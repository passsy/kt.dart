# kt_stdlib: Kotlin Standard Library ported to Dart

[![Pub](https://img.shields.io/pub/v/kt_stdlib.svg)](https://pub.dartlang.org/packages/kt_stdlib)

This project brings Kotlins beautiful [Kotlin Standard library](https://kotlinlang.org/api/latest/jvm/stdlib/index.html) to Dart/Flutter projects. It's a great addition to [`dart:core`](https://api.dartlang.org/stable/dart-core/dart-core-library.html) and includes collections (`KtList`, `KtMap`, `KtSet`) as well as and other packages which are useful in every Dart/Flutter app. 

## Motivation

Dart's [`dart:core`](https://api.dartlang.org/stable/dart-core/dart-core-library.html) package is great but sometimes not as straight-forward as Kotlins `kotlin-stdlib`.

Here are a few examples what this project offers: _(click to expand)_

<details>
  <summary>Immutable collections by default</summary>

`dart:core` - `List`

```dart
// Dart's List is mutable by default
final dartList = [1, 2, 3];
dartList.add(4); // mutation is by default possible
assert(dartList.length == 4);

// You can create immutable Dart Lists but they still offer mutation methods
final immutableDartList = List.unmodifiable(dartList);
immutableDartList.add(5); // Unsupported operation: Cannot add to an unmodifiable list
// This runtime error could have been cought by the compiler with better types 
```

`kt_stdlib:collection` - `KtList`
```dart
// KtLists are immutable by default, add(T) doesn't exist
final ktList = listOf(1, 2, 3);
// The method 'add' isn't defined for the class 'KtList<int>'.
ktList.add(4); // compilation error

// Mutation is only possible with KtMutableList
final mutableKtList = mutableListOf(1, 2, 3);
mutableKtList.add(4); // works!
```
</details>

<details>
  <summary>Deep equals</summary>

`dart:core` - `List`
```dart
// Comparing two Dart Lists works only by identity
final a = [1, 2, 3, 4];
final b = [1, 2, 3, 4];
print(a == b); // false, huh?

// content based comparisons require unnecessary glue code
Function listEq = const ListEquality().equals;
print(listEq(a, b)); // true

final x = {1: ["a", "b", "c"], 2: ["xx", "yy", "zz"]};
final y = {1: ["a", "b", "c"], 2: ["xx", "yy", "zz"]};
Function mapEq = const MapEquality().equals;
print(mapEq(x, y)); // false, wth?!

Function deepEq = const DeepCollectionEquality().equals;
print(deepEq(x, y)); // true, finally
```
`kt_stdlib:collection` - `KtList`
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
</details>

<details>
  <summary>Useful Helpers</summary>
</details>


# Packages

> ## [collection](https://github.com/passsy/kt_stdlib/tree/master/lib/src/collection)
>
> `import 'package:kt_stdlib/collection.dart';`
> 
> Collection types, such as `KtIterable`, `KtCollection`, `KtList`, `KtSet`, `KtMap`  with over 150 methods as well as related top-level functions.
The collections are immutable by default but offer a mutable counterpart i.e. `KtMutableList`.
>

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
