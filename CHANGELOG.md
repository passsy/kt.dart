## 0.5.0 (unreleased)

[diff v0.4.1...master](https://github.com/passsy/kotlin.dart/compare/v0.4.1...master)

## 0.4.1

[diff v0.4.0...v0.4.1](https://github.com/passsy/kotlin.dart/compare/v0.4.0...v0.4.1)

Improve Readme which renders correctly on pub.

## 0.4.0

[diff v0.3.0...v0.4.0](https://github.com/passsy/kotlin.dart/compare/v0.3.0...v0.4.0)

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


## 0.3.0

[diff v0.2.0...v0.3.0](https://github.com/passsy/kotlin.dart/compare/v0.2.0...v0.3.0)

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

[diff v0.1.0...v0.2.0](https://github.com/passsy/dart_kollection/compare/v0.1.0...v0.2.0)

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