## 0.7.0

The library has be upgrade to use [`Static Extension Methods`](https://github.com/dart-lang/language/issues/41).

### Interop

This update also includes extensions for Dart collections which allow easy interoperability between dart and kt.dart collections using the `.kt` and `.dart` getters.

```dart
  // New: Converting dart collections to KtDart collections (mutable views)
  final KtMutableList<String> ktList = ["hey"].kt;
  final KtMutableSet<String> ktSet = {"hey"}.kt;
  final KtMutableMap<String, int> ktMap = {"hey": 1}.kt;

  // Converting KtDart collections to dart collections
  final List<String> dartList = KtList.of("hey").dart;
  final Set<String> dartSet = KtSet.of("hey").dart;
  final Map<String, int> dartMap = KtMap.from({"hey": 1}).dart;
```

Note: `["Hello", "World"].kt` returns a `KtMutableList<String>` and mutations are reflected on the original dart list. It is not a copy! Because it doesn't copy it is very cheap and only syntax sugar.
 
To convert dart collections to their immutable kt.dart counterparts use: `.toImmutableList()`, `.toImmutableSet()`, `.toImmutableMap()`

```dart
  // New: Make dart collections immutable
  final KtList<String> list = ["hey"].toImmutableList();
  final KtSet<String> set = {"hey"}.toImmutableSet();
  final KtMap<String, int> map = {"hey": 1}.toImmutableMap();
```

### Possible breaking changes

- Relax `sortBy`/`sortByDescending`, `maxBy`/`minBy` typing to work better with ints and doubles [#116](https://github.com/passsy/kt.dart/pull/116)
```dart
// Was: int doesn't not implement Comparable<int> but Comparable<num>
// minBy therefore required some help to figure out the correct type (<num>) 
users.minBy<num>((it) => it.age);

// Now: minBy doesn't require the Comparable (num) to have the same same as the value (int).
users.minBy((it) => it.age);
```
- Remove unnecessary generic `R` from `KtIterable.zipWithNext` [#118](https://github.com/passsy/kt.dart/pull/118)

### New Extensions
- `KtPair` and `KtTriple` now have a new `toList()` function to convert the values to a `KtList`
- `KtList?.orEmpty()` returns an empty list when the list is `null`
- `KtSet?.orEmpty()` returns an empty set when the set is `null`
- `KtMap?.orEmpty()` returns an empty map when the map is `null`
- `KtMap.ifEmpty(() -> defaultValue)` returns the default value when the map is empty
- `KtIterable<KtIterable<T>>.flatten()` flattens the nested collections to `KtIterable<T>`
- `KtIterable<KtPair<T, U>>.unzip(): KtPair<KtList<T>, KtList<U>>` unzips list of pairs to list of their first and second values
- `KtIterable<Comparable<T>>.min()` returns the smallest element of any comparable iterable
- `KtIterable<Comparable<T>>.max()` returns the largest element of any comparable iterable


## 0.7.0-dev.4

- New extension `Iterable.toImmutableList(): KtList`
- New extension `Iterable.toImmutableSet(): KtSet`
- New extension `KtIterable<num>.average(): double`
- Relax `sortBy`/`sortByDescending`, `maxBy`/`minBy` typing to work better with ints and doubles
```dart
// Was: int doesn't not implement Comparable<int> but Comparable<num>
// minBy therefore required some help to figure out the correct type (<num>) 
users.minBy<num>((it) => it.age);

// Now: minBy doesn't require the Comparable (num) to have the same same as the value (int).
users.minBy((it) => it.age);
```

## 0.7.0-dev.3

- Rename `(List|Set|Map).immutable()` extension to `.toImmutableList()` to match Dart SDK naming schema. 
- Remove `int.rangeTo(X)` extension. Please use the [`dartx`](https://github.com/leisim/dartx) as replacement which offers the same extension
- Remove `T.to(X)` extension to create a `KtPair`. It's too general and should be offered by the dart SDK not a 3rd party package

## 0.7.0-dev.2

New `.dart` extensions to convert KtDart collections back to dart collections.

```dart
  // New: Converting dart collections to KtDart collections (mutable views)
  final KtMutableList<String> ktList = ["hey"].kt;
  final KtMutableSet<String> ktSet = {"hey"}.kt;
  final KtMutableMap<String, int> ktMap = {"hey": 1}.kt;

  // Converting KtDart collections to dart collections
  final List<String> dartList = KtList.of("hey").dart;
  final Set<String> dartSet = KtSet.of("hey").dart;
  final Map<String, int> dartMap = KtMap.from({"hey": 1}).dart;
```

## 0.7.0-dev.1

**KtDart makes full use of darts static extension methods, introduced with Dart 2.6.**

The public API stays unchanged and is backwards compatible.

### Improved interopt with dart collections

It is now easier then ever to convert dart to ktdart collections and vice versa. Use the `.kt` property to convert dart collections to KtDart collections. (Note: `.kt` create a view, which allows you to mutate the original dart collection).
 
```dart
  // New: Make dart collections immutable
  final KtList<String> list = ["hey"].immutable();
  final KtSet<String> set = {"hey"}.immutable();
  final KtMap<String, int> map = {"hey": 1}.immutable();

  // New: Converting dart collections to KtDart collections (mutable views)
  final KtMutableList<String> ktList = ["hey"].kt;
  final KtMutableSet<String> ktSet = {"hey"}.kt;
  final KtMutableMap<String, int> ktMap = {"hey": 1}.kt;

  // Converting KtDart collections to dart collections
  final List<String> dartList = KtList.of("hey").asList();
  final Set<String> dartSet = KtSet.of("hey").asSet();
  final Map<String, int> dartMap = KtMap.from({"hey": 1}).asMap();
```

### Tuple improvements

`KtPair`s can now created with the `T0.to(T1)` extension.
```dart
final KtPair<String, int> pair = "foo".to(42);
```

Also, `KtPair` and `KtTriple` now have a new `toList()` function to convert the values to a `KtList`.


### New Extensions

- `KtList?.orEmpty()` returns an empty list when the list is `null`
- `KtSet?.orEmpty()` returns an empty set when the set is `null`
- `KtMap?.orEmpty()` returns an empty map when the map is `null`
- `KtMap.ifEmpty(() -> defaultValue)` returns the default value when the map is empty
- `KtIterable<KtIterable<T>>.flatten()` flattens the nested collections to `KtIterable<T>`
- `KtIterable<KtPair<T, U>>.unzip(): KtPair<KtList<T>, KtList<U>>` unzips list of pairs to list of their first and second values
- `KtIterable<Comparable<T>>.min()` returns the smallest element of any comparable iterable
- `KtIterable<Comparable<T>>.max()` returns the largest element of any comparable iterable



## 0.6.2

[diff v0.6.1...v0.6.2](https://github.com/passsy/kt.dart/compare/v0.6.1...v0.6.2)


- [#96](https://github.com/passsy/kt.dart/pull/96) Dart 2.0.0 comparability. (Was only Dart 2.1.0 compatible). 
- [#97](https://github.com/passsy/kt.dart/pull/97) Fix broken links to lib classes in documentation
- [#97](https://github.com/passsy/kt.dart/pull/97) Adjust analyzer rules. Add new ones and explain why others aren't active. Adjusted the code accordingly


## 0.6.1

[diff v0.6.0...v0.6.1](https://github.com/passsy/kt.dart/compare/v0.6.0...v0.6.1)

- [#92](https://github.com/passsy/kt.dart/pull/92) Improve pub score by changing comments to `///`


## 0.6.0

[diff v0.5.0...v0.6.0](https://github.com/passsy/kt.dart/compare/v0.5.0...v0.6.0)

This major update of kt.dart add 10+ extension methods for `KtMap` and makes working with maps even easier.

### Behavior Changes

The properties `KtList.list: List`,`KtSet.set: Set` are now deprecated and `KtMap.map: Map` was **removed**. Those properties where used to convert kt.dart collections to dart collections.
Instead use the new `KtList.asList(): List`, `KtSet.asSet(): Set`, `KtMa.asMap(): Map` methods. 
The old properties returned copies of the collections. 
The new `as`-methods return views of the original collections and reflect changes of the original data.

This breaking change was necessary because the property `KtMap.map: Map<K, V>` was conflicting with `KtMap.map(MapEntry<K, V> -> R) : KtList<R>` to map the entries to items of a `KtList`.
Read about further details [here](https://github.com/passsy/kt.dart/issues/79).

If you have used properties to iterate over the collections using a for-loop you should now always use `iter` which is available for all kt.dart collections.

```dart
for (final element in listOf("a", "b", "c").iter) {
  print(element); 
}
for (final element in setOf("a", "b", "c").iter) {
  print(element); 
}
for (final p in mapFrom({1: "Bulbasaur", 2: "Ivysaur"}).iter) {
  print("${p.key} -> ${p.value}"); 
}
```

### Additions
- [#86](https://github.com/passsy/kt.dart/pull/86) New: `KtMap.map` Returns a list containing the results of applying the given `transform` function to each entry in the original map.
- [#86](https://github.com/passsy/kt.dart/pull/86) New: `KtMap.iter` Access to a `Iterable` to be used in for-loops
- [#87](https://github.com/passsy/kt.dart/pull/87) New: `KtMap.count` Returns the number of entries matching the given [predicate] or the number of entries when `predicate = null`.
- [#89](https://github.com/passsy/kt.dart/pull/89) New: `KtMap.minBy` Returns the first entry yielding the smallest value of the given function or `null` if there are no entries.
- [#89](https://github.com/passsy/kt.dart/pull/89) New: `KtMap.minWith` Returns the first entry having the smallest value according to the provided `comparator` or `null` if there are no entries.
- [#89](https://github.com/passsy/kt.dart/pull/89) New: `KtMap.maxBy` Returns the first entry yielding the largest value of the given function or `null` if there are no entries.
- [#89](https://github.com/passsy/kt.dart/pull/89) New: `KtMap.maxWith` Returns the first entry having the largest value according to the provided `comparator` or `null` if there are no entries.
- [#90](https://github.com/passsy/kt.dart/pull/90) New: `KtMap.toList` Returns a `KtList` containing all key-value pairs.
- [#78](https://github.com/passsy/kt.dart/pull/78) New: `KtMap.forEach` Performs given `action` on each key/value pair from this map. thanks @acherkashyn
- [#80](https://github.com/passsy/kt.dart/pull/80) New: `KtMap.none` Returns `true` if there is no entries in the map that match the given `predicate`. thanks @acherkashyn
- [#80](https://github.com/passsy/kt.dart/pull/80) New: `KtMap.all` Returns true if all entries match the given `predicate`. thanks @acherkashyn
- [#80](https://github.com/passsy/kt.dart/pull/80) New: `KtMap.any` Returns true if there is at least one entry that matches the given `predicate`. thanks @acherkashyn
- [#84](https://github.com/passsy/kt.dart/pull/84) New: `KtMap.filterKeys` Returns a map containing all key-value pairs with keys matching the given `predicate`.
- [#84](https://github.com/passsy/kt.dart/pull/84) New: `KtMap.filterValues` Returns a map containing all key-value pairs with values matching the given `predicate`.
- [#79](https://github.com/passsy/kt.dart/pull/79) New: `KtMap.asMap` Returns a read-only dart:core `Map`
- [#79](https://github.com/passsy/kt.dart/pull/79) New: `KtMutableMap.asMap` Creates a `Map` instance that wraps the original `KtMap`. It acts as a view.
---
- [#75](https://github.com/passsy/kt.dart/pull/75) New: `KtIterable.takeWhile` Returns a list containing first elements satisfying the given `predicate`.
- [#76](https://github.com/passsy/kt.dart/pull/76) New: `KtIterable.takeLastWhile` Returns a list containing last elements satisfying the given `predicate`.
---
- [#73](https://github.com/passsy/kt.dart/pull/73) New: `KtList.takeLast`, Returns a list containing last `n` elements.
- [#79](https://github.com/passsy/kt.dart/pull/79) New: `KtList.asList` Returns a read-only dart:core `List`
- [#79](https://github.com/passsy/kt.dart/pull/79) New: `KtMutableList.asList` Creates a `List` instance that wraps the original `KtList`. It acts as a view.
---
- [#79](https://github.com/passsy/kt.dart/pull/79), [#91](https://github.com/passsy/kt.dart/pull/91) New: `KtSet.asSet` Returns a read-only dart:core `Set`
- [#79](https://github.com/passsy/kt.dart/pull/79) New: `KtMutableSet.asSet` Creates a `Set` instance that wraps the original `KtSet`. It acts as a view.


### Bugfixes
- [#74](https://github.com/passsy/kt.dart/pull/74) Fix: `KtList.dropLastWhile` was off by 1
- [#88](https://github.com/passsy/kt.dart/pull/88) Fix: `KtIterable.minWith` returned the max value


### Documentation
- [#68](https://github.com/passsy/kt.dart/pull/68) Document `KtSet` constructors
- [#70](https://github.com/passsy/kt.dart/pull/70) Fix README typos, thanks @RedBrogdon

### Misc.
- [#69](https://github.com/passsy/kt.dart/pull/69) `KtMutableListIterator` throws `IndexOutOfBoundsException` when calling `set` before `next` was called
- [#81](https://github.com/passsy/kt.dart/pull/81) Force dartfmt on CI
- [#83](https://github.com/passsy/kt.dart/pull/83) Improve .gitignore

## 0.5.0

[diff v0.4.2...v0.5.0](https://github.com/passsy/kt.dart/compare/v0.4.2...v0.5.0)

Project has been renamed to `kt.dart`. If you're using a previous version upgrade like this:

`pubspec.yaml`
```diff
dependencies:
-  dart_kollection: ^0.3.0
-  kotlin_dart: ^0.4.0
+  kt_dart: ^0.5.0
```

`your_source.dart`
```diff
- import 'package:dart_kollection/dart_kollection.dart';
- import 'package:kotlin_dart/kotlin.dart';
+ import 'package:kt_dart/kt.dart';
```

- [#66](https://github.com/passsy/kt.dart/pull/66) Rename `KPair` -> `KtPair` and `KTriple` -> `KtTriple`
- [#67](https://github.com/passsy/kt.dart/pull/67) Rename package `kotlin_dart` -> `kt_dart`

## 0.4.3

[diff v0.4.2...v0.4.3](https://github.com/passsy/kt.dart/compare/v0.4.2...v0.4.3)

Deprecate package `kotlin_dart` and recommend users to migrate to `kt_dart`.

## 0.4.2

[diff v0.4.1...v0.4.2](https://github.com/passsy/kt.dart/compare/v0.4.1...v0.4.2)

Shorten pub project description to make pana happy.

## 0.4.1

[diff v0.4.0...v0.4.1](https://github.com/passsy/kt.dart/compare/v0.4.0...v0.4.1)

Improve Readme which renders correctly on pub.

## 0.4.0

[diff v0.3.0...v0.4.0](https://github.com/passsy/kt.dart/compare/v0.3.0...v0.4.0)

The `kollection` project was migrated to `kotlin.dart` where `kollection` becomes the `collection` module.

### Upgrade

`pubspec.yaml`
```diff
dependencies:
-  dart_kollection: ^0.3.0
+  kotlin_dart: ^0.4.0
```

`your_source.dart`
```diff
- import 'package:dart_kollection/dart_kollection.dart';
+ import 'package:kotlin_dart/kotlin.dart';
```

### Breaking Changes
- [#64](https://github.com/passsy/kotlin.dart/pull/64) The class prefix of all collections has been changed from `K` to `Kt` (`KList` -> `KtList`)
- [#60](https://github.com/passsy/kotlin.dart/pull/60) `listOf` now accepts up to 10 non-null arguments instead of an `Iterable`. Use `listFrom` to create `KtList`s from an dart `Iterable`s
- [#60](https://github.com/passsy/kotlin.dart/pull/60) Collections can now be created with factory constructors i.e. `KtList.of(1, 2 ,3)`. Both APIs, factory constructor and function based one, **are equally supported.** It only depends on your personal taste.

Here is a list of all collection creation APIs.
#### Kotlin like, function based syntax
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

## 0.3.2

[diff v0.3.1...v0.3.12](https://github.com/passsy/kt.dart/compare/v0.3.1...v0.3.2)

Deprecate package `dart_kollection` in favour of `kt_dart`

## 0.3.1

[diff v0.3.0...v0.3.1](https://github.com/passsy/kt.dart/compare/v0.3.0...v0.3.1)

Deprecate all APIs and advise users to upgrade to `kotlin.dart`


## 0.3.0

[diff v0.2.0...v0.3.0](https://github.com/passsy/kt.dart/compare/v0.2.0...v0.3.0)

### Summary

This release of Kollection fully covers the project with unit tests, from 52% to 99% :tada:.
By doing that bugs where discovered and fixed.

Because Dart doesn't support [non-nullable types](https://github.com/dart-lang/sdk/issues/22) yet, this update manually checks all method arguments at runtime. 
Passing `null` in any method will throw `ArgumentError` unless documented otherwise.

### Behavior changes

- [#36](https://github.com/passsy/dart_kollection/pull/36) All method arguments are now validated for nullability. If a argument isn't documented as "nullable" the method will throw `ArgumentError` (when asserts are enabled)
- [#51](https://github.com/passsy/dart_kollection/pull/51), [#46](https://github.com/passsy/dart_kollection/pull/46) `KIterable<T>.associateWithTo`, `Kiterable<T>.filterTo`, `KIterable<T>.filterIndexedTo`, `KIterable<T>.filterNotTo`, `KIterable<T>.filterNotNullTo` , `KIterable<T>.groupByTo` ,`KMap<T>.mapKeysTo` ,`KMap<T>.mapValuesTo`, `KIterable.toCollection` did not compile when called directly due to [dart-lang/sdk/issues/35518](https://github.com/dart-lang/sdk/issues/35518). The type of `destination` of those methods has been changed to a dynamic type (i.e. `KMutableList<T>` -> `KMutableList<dynamic>`). Those methods will now be checked at runtime. This has one advantage: It allows to pass in contravariant types.
```dart
final KIterable<int> iterable = listOf([4, 25, -12, 10]);
final result = mutableListOf<num>(); // covariant!
final filtered = iterable.filterIndexedTo(result, (i, it) => it < 10);
expect(identical(result, filtered), isTrue);
expect(result, listOf([4, -12]));
```
- [#56](https://github.com/passsy/dart_kollection/pull/56) `KMutableEntry.setValue` now throws `UnimplementedError` because of bug [#55](https://github.com/passsy/dart_kollection/issues/55). It anyways never worked.
- [#58](https://github.com/passsy/dart_kollection/pull/58) `KSet` doesn't allow mutation of its elements with via `set` getter. It is now really immutable.

### API changes

- [#38](https://github.com/passsy/dart_kollection/pull/38) Breaking: Removed `hashMapFrom(KIterable<KPair>)` because, unlike Kotlin, it feels unnatural in Dart. Instead use [`hashMapOf`](https://github.com/passsy/dart_kollection/blob/6065e3b93e462e08061df2202e4638d7577caad8/lib/src/collections.dart#L59) to construct a [`KMutableMap`](https://github.com/passsy/dart_kollection/blob/efbabc1b45125f26557457344c56850107f58b7b/lib/src/k_map_mutable.dart#L9)
- [#17](https://github.com/passsy/dart_kollection/pull/17) Breaking: [`KMap.associateBy`](https://github.com/passsy/dart_kollection/blob/94b5b7c6be1fb6c34047dd72692849f42b77b0e9/lib/src/k_iterable.dart#L56) now takes only a single parameter (`K Function(T) keySelector`). If you used `valueTransform` use [`KMap.associateByTransform`](https://github.com/passsy/dart_kollection/blob/94b5b7c6be1fb6c34047dd72692849f42b77b0e9/lib/src/k_iterable.dart#L66) as replacement
- [#23](https://github.com/passsy/dart_kollection/pull/23) New [`KMutableList.[]=`](https://github.com/passsy/dart_kollection/blob/94b5b7c6be1fb6c34047dd72692849f42b77b0e9/lib/src/k_list_mutable.dart#L60) operator. Example: `list[4] = "Hello"`
- [#47](https://github.com/passsy/dart_kollection/pull/47) New [`KMap`](https://github.com/passsy/dart_kollection/blob/6065e3b93e462e08061df2202e4638d7577caad8/lib/src/k_map.dart#L12) methods [`filter`](https://github.com/passsy/dart_kollection/blob/bbe6d2482a65193a590accc2fc02f23bddbb1e16/lib/src/k_map.dart#L101), [`filterTo`](filterTo), [`filterNot`](https://github.com/passsy/dart_kollection/blob/bbe6d2482a65193a590accc2fc02f23bddbb1e16/lib/src/k_map.dart#L121), [`filterNotTo`](https://github.com/passsy/dart_kollection/blob/bbe6d2482a65193a590accc2fc02f23bddbb1e16/lib/src/k_map.dart#L133), 

- [#37](https://github.com/passsy/dart_kollection/pull/37) [`KCollection.random`](https://github.com/passsy/dart_kollection/blob/bbe6d2482a65193a590accc2fc02f23bddbb1e16/lib/src/k_collection.dart#L52) now optionally accepts a `Random` as argument which can be seeded
- [#39](https://github.com/passsy/dart_kollection/pull/39) [`KMutableList.removeAt`](https://github.com/passsy/dart_kollection/blob/bbe6d2482a65193a590accc2fc02f23bddbb1e16/lib/src/collection/list_mutable.dart#L128) now throws [`IndexOutOfBoundsException`](https://github.com/passsy/dart_kollection/blob/6065e3b93e462e08061df2202e4638d7577caad8/lib/src/exceptions.dart#L1) when `index` exceeds length or is negative
- [#18](https://github.com/passsy/dart_kollection/pull/18) [`KMutableCollection`](https://github.com/passsy/dart_kollection/blob/6065e3b93e462e08061df2202e4638d7577caad8/lib/src/k_collection_mutable.dart#L8): [`addAll`](https://github.com/passsy/dart_kollection/blob/932922109c40c7ee86878e546c2628b8d9e9bdb0/lib/src/k_collection_mutable.dart#L37), [`removeAll`](https://github.com/passsy/dart_kollection/blob/932922109c40c7ee86878e546c2628b8d9e9bdb0/lib/src/k_collection_mutable.dart#L44) and [`retainAll`](https://github.com/passsy/dart_kollection/blob/932922109c40c7ee86878e546c2628b8d9e9bdb0/lib/src/k_collection_mutable.dart#L51) now receive [`KIterable`](https://github.com/passsy/dart_kollection/blob/6065e3b93e462e08061df2202e4638d7577caad8/lib/src/k_iterable.dart#L8) as parameter, was [`KCollection`](https://github.com/passsy/dart_kollection/blob/6065e3b93e462e08061df2202e4638d7577caad8/lib/src/k_collection.dart#L10)

### Bug fixes

- [#18](https://github.com/passsy/dart_kollection/pull/18) Fixed [`KList.first`](https://github.com/passsy/dart_kollection/blob/5cd8369d88c35b426b7415c6e0f96fba5ab540d5/lib/src/extension/list_extension_mixin.dart#L52) stackoverflow
- [#44](https://github.com/passsy/dart_kollection/pull/44) Fixed [`Klist.single`](https://github.com/passsy/dart_kollection/blob/5cd8369d88c35b426b7415c6e0f96fba5ab540d5/lib/src/extension/list_extension_mixin.dart#L178) stackoverflow
- [#24](https://github.com/passsy/dart_kollection/pull/24) Fixed [`KList.last`](https://github.com/passsy/dart_kollection/blob/5cd8369d88c35b426b7415c6e0f96fba5ab540d5/lib/src/extension/list_extension_mixin.dart#L120) which returned `first`
- [#20](https://github.com/passsy/dart_kollection/pull/20) Fixed [`KIterable.firstOrNull`](https://github.com/passsy/dart_kollection/blob/94b5b7c6be1fb6c34047dd72692849f42b77b0e9/lib/src/extension/iterable_extension_mixin.dart#L458) which threw [`NoSuchElementException`](https://github.com/passsy/dart_kollection/blob/6065e3b93e462e08061df2202e4638d7577caad8/lib/src/exceptions.dart#L12) for empty lists, now returns `null`
- [#22](https://github.com/passsy/dart_kollection/pull/22) Fixed [`KIterable.mapIndexedTo`](https://github.com/passsy/dart_kollection/blob/94b5b7c6be1fb6c34047dd72692849f42b77b0e9/lib/src/k_iterable.dart#L462), [`KIterable.mapIndexedNotNullTo`](https://github.com/passsy/dart_kollection/blob/94b5b7c6be1fb6c34047dd72692849f42b77b0e9/lib/src/k_iterable.dart#L453) couldn't be called due to a generic compilation error
- [#26](https://github.com/passsy/dart_kollection/pull/26) Fixed [`KList.containsAll`](https://github.com/passsy/dart_kollection/blob/5cd8369d88c35b426b7415c6e0f96fba5ab540d5/lib/src/collection/list.dart#L36) returned false when all elements ar in list
- [#28](https://github.com/passsy/dart_kollection/pull/28) Fixed [`KListIterator.nextIndex`](https://github.com/passsy/dart_kollection/blob/5cd8369d88c35b426b7415c6e0f96fba5ab540d5/lib/src/collection/iterator.dart#L70) was off by one, now returns the index of the element which will be returned by `next()`
- [#30](https://github.com/passsy/dart_kollection/pull/30) Fixed [`KMutableList.sortBy`](https://github.com/passsy/dart_kollection/blob/5cd8369d88c35b426b7415c6e0f96fba5ab540d5/lib/src/extension/list_mutable_extension_mixin.dart#L26) and [`sortByDescending`](https://github.com/passsy/dart_kollection/blob/5cd8369d88c35b426b7415c6e0f96fba5ab540d5/lib/src/extension/list_mutable_extension_mixin.dart#L37) not sorting the [`KMutableList`](https://github.com/passsy/dart_kollection/blob/6065e3b93e462e08061df2202e4638d7577caad8/lib/src/k_list_mutable.dart#L7) but a copy
- [#31](https://github.com/passsy/dart_kollection/pull/31) Fixed [`KIterable.none`](https://github.com/passsy/dart_kollection/blob/94b5b7c6be1fb6c34047dd72692849f42b77b0e9/lib/src/extension/iterable_extension_mixin.dart#L1010) always returned `true` (Was always working for `KCollection`)
- [#51](https://github.com/passsy/dart_kollection/pull/51) Fixed [`KSet.==()`](https://github.com/passsy/dart_kollection/blob/5cd8369d88c35b426b7415c6e0f96fba5ab540d5/lib/src/collection/set.dart#L51) returns false for `setOf<int>([1, 2, 3]) == setOf<num>([1, 2, 3])`

### Documentation changes

- [#57](https://github.com/passsy/dart_kollection/pull/57) Document [`hashSetOf`](https://github.com/passsy/dart_kollection/blob/e8f6a724dec93a1297bbf703b0e69b04a4607f7b/lib/src/collections.dart#L99) and [`linkedSetOf`](https://github.com/passsy/dart_kollection/blob/e8f6a724dec93a1297bbf703b0e69b04a4607f7b/lib/src/collections.dart#L91)
- [#19](https://github.com/passsy/dart_kollection/pull/19) [`KIterable.any`](https://github.com/passsy/dart_kollection/blob/5cd8369d88c35b426b7415c6e0f96fba5ab540d5/lib/src/k_iterable.dart#L31) document return value when called without `predicate`
- [#51](https://github.com/passsy/dart_kollection/pull/51) Document expected type of now dynamically typed `KIterable<T>.associateWithTo`, `Kiterable<T>.filterTo`, `KIterable<T>.filterIndexedTo`, `KIterable<T>.filterNotTo`, `KIterable<T>.filterNotNullTo` , `KIterable<T>.groupByTo` ,`KMap<T>.mapKeysTo` ,`KMap<T>.mapValuesTo`, `KIterable.toCollection` 

### Other changes

- Added a **lot of tests** [#19](https://github.com/passsy/dart_kollection/pull/19), [#27](https://github.com/passsy/dart_kollection/pull/27), [#32](https://github.com/passsy/dart_kollection/pull/32), [#33](https://github.com/passsy/dart_kollection/pull/33), [#34](https://github.com/passsy/dart_kollection/pull/34), [#35](https://github.com/passsy/dart_kollection/pull/35), [#39](https://github.com/passsy/dart_kollection/pull/39), [#40](https://github.com/passsy/dart_kollection/pull/40), [#41](https://github.com/passsy/dart_kollection/pull/41), [#42](https://github.com/passsy/dart_kollection/pull/42), [#43](https://github.com/passsy/dart_kollection/pull/43), [#45](https://github.com/passsy/dart_kollection/pull/45), [#53](https://github.com/passsy/dart_kollection/pull/53), [#54](https://github.com/passsy/dart_kollection/pull/54), [#58](https://github.com/passsy/dart_kollection/pull/58), 
- [#48](https://github.com/passsy/dart_kollection/pull/48), [#49](https://github.com/passsy/dart_kollection/pull/49), [#50](https://github.com/passsy/dart_kollection/pull/50), [#59](https://github.com/passsy/dart_kollection/pull/59) Activated many lint checks
- [#25](https://github.com/passsy/dart_kollection/pull/25) `tool/run_coverage_locally.sh` now installs deps only when not installed and prints resulting HTML report path


## 0.2.0

[diff v0.1.0...v0.2.0](https://github.com/passsy/kt.dart/compare/v0.1.0...v0.2.0)

### Behavior change
- [#6](https://github.com/passsy/dart_kollection/pull/6) Breaking: `KMutableIterator.remove` now throws `UnimplementedError` because of bug [#5](https://github.com/passsy/dart_kollection/issues/5)

### API changes
- [#1](https://github.com/passsy/dart_kollection/pull/1) Add `Set<T> get set` returning the internal dart set
- [#1](https://github.com/passsy/dart_kollection/pull/1) Add `Map<K, V> get map` returning the intenral dart set
- [#7](https://github.com/passsy/dart_kollection/pull/7) Add `KMap.toMap` and `KMap.toMutableMap`
- [#8](https://github.com/passsy/dart_kollection/pull/8) Add `KMap.isNotEmpty`
- 3e3228e Add `KMap.toString()`
- [#9](https://github.com/passsy/dart_kollection/pull/9) Add `Map.plus`, `Map.minus` and  `operator +(KMap<K, V> map)`, `operator -(K key)`
- [#12](https://github.com/passsy/dart_kollection/pull/12) Remove const constructors from collection interfaces
- [#13](https://github.com/passsy/dart_kollection/pull/13) Remove default implementations from collection interfaces

### Documentation changes
- [#15](https://github.com/passsy/dart_kollection/pull/15) Add documentation for `compareBy` and `compareByDescending`

### Other changes
- [#2](https://github.com/passsy/dart_kollection/pull/2) Travis CI [#2](https://github.com/passsy/dart_kollection/pull/2)
- [#3](https://github.com/passsy/dart_kollection/pull/3), [#4](https://github.com/passsy/dart_kollection/pull/4) Code coverage
- [#10](https://github.com/passsy/dart_kollection/pull/10) Test `KMutableList.fill`
- [#11](https://github.com/passsy/dart_kollection/pull/11) Test `KPair`, `KTriple`
- [#14](https://github.com/passsy/dart_kollection/pull/14) Test Exceptions
- [#15](https://github.com/passsy/dart_kollection/pull/15) Test Comparators `naturalOrder()`, `reverseOrder()`
- [#15](https://github.com/passsy/dart_kollection/pull/15) Test `reverse(Comparator)` util function
- [6dd0d85](https://github.com/passsy/dart_kollection/pull/6/commits/6dd0d85) Reformatted with dartfmt (80 chars) 


## 0.1.0

Initial release for 

- `KList`/`KMutableList`
- `KSet`/`KMutableSet`
- `KMap`/`KMutableMap`

with tons of extensions waiting for you to use them!