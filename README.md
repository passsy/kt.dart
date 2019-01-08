# kt_stdlib: Kotlin Standard Library ported to Dart

[![Pub](https://img.shields.io/pub/v/kt_stdlib.svg)](https://pub.dartlang.org/packages/kt_stdlib)

This project brings Kotlins beautiful [Kotlin Standard library](https://kotlinlang.org/api/latest/jvm/stdlib/index.html) to Dart/Flutter projects. It's a great addition to [`dart:core`](https://api.dartlang.org/stable/dart-core/dart-core-library.html) and includes collections (`KtList`, `KtMap`, `KtSet`) as well as and other packages which are useful in every Dart/Flutter app. 

## Motivation

Dart's [`dart:core`](https://api.dartlang.org/stable/dart-core/dart-core-library.html) package is great but sometimes not as straight-forward as Kotlins `kotlin-stdlib`.

Here are a few examples what this project offers: _(click to expand)_

<details>
  <summary>Immutable collections by default</summary>

### `dart:core` collections

Dart's `List` is mutable by default. The immutable `List.unmodifiable` is the same type but the mutation methods throw at runtime.

```dart
final dartList = [1, 2, 3];
dartList.add(4); // mutation is by default possible
assert(dartList.length == 4);

final immutableDartList = List.unmodifiable(dartList);
immutableDartList.add(5); // throws: Unsupported operation: Cannot add to an unmodifiable list
```

Dart's mutable `List` is undistinguishable from an immutable `List` which might cause errors.
```dart
void addDevice(List<Widget> widgets, Device device) {
  // no way to check whether widgets is mutable or not
  // add might or might now throw
  widgets.add(_deviceRow());
  widgets.add(Divider(height: 1.0));
}
```

### `kt_stdlib` collections

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

All collection types has mutable counterparts:
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

Dart's `List` works like `Array` in Java. Equals doesn't compare the items. Equals only checks the identity.
To compare the contents you can use `Equality` helper methods from `'package:collection/collection.dart'`. Something one might forget accidentally.

```dart
// Comparing two Dart Lists works only by identity
final a = [1, 2, 3, 4];
final b = [1, 2, 3, 4];
print(a == b); // false, huh?

// content based comparisons require unnecessary glue code
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

### `kt_stdlib` collections

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
