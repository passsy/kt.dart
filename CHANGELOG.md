## 0.3.0 (unreleased)

[diff v0.2.0...master](https://github.com/passsy/dart_kollection/compare/v0.2.0...master)

This release of Kollection fully covers the project with unit tests.
By doing that bugs where discovered and fixed.

Because Dart doesn't support Non-nullable types, this update manually checks all method arguments at runtime. 
Passing `null` in any method will throw `ArgumentError` unless documented otherwise.

### Breaking change

- #36 All method arguments are now validated for nullability. If a argument isn't documented as `nullable` the method will throw `ArgumentError` (when asserts are enabled)
- #38 Removed `hashMapFrom(KIterable<KPair>)` because, unlike Kotlin, it feels unnatural in Dart
- #17 `KMap.associateBy` not takes only a single parameter (`K Function(T) keySelector`). if you used `valueTransform` use `KMap.associateByTransform` as replacement
- 

### Bug fixes

- #18 Fixed `KList.first()` stackoverflow
- #44 Fixed `Klist.single()` stackoverflow
- #24 Fixed `KList.last()` which returned `first()`
- #20 Fixed `KIterable.firstOrNull` which threw `NoSuchElementException` for empty lists, now returns `null`
- #22 Fixed `KList.mapIndexedTo`, `KList.mapIndexedNotNull` couldn't be called due to a generic compilation error
- #26 Fixed `KList.containsAll` returned false when all elements ar in list
- #28 Fixed `KListIterator.nextIndex` was off by one, now returns the index of the element returned by `next()`
- #30 Fixed `KMutableList.sortBy` and `sortByDescending` not sorting the `KMutableList` but a copy
- #31 Fixed `KIterable.none` always returned `true` (Was always working for `KCollection`)
- #51 Fixed `KSet.==()` returns false for `setOf<int>([1, 2, 3]) == setOf<num>([1, 2, 3])`

### API changes

- #23 New `KMutableList.[]=` operator. Example: `list[4] = "Hello"`
- #47 New `KMap` methods `filter`, `filterTo`, `filterNot`, `filterNotTo`, 
- #51, #46 `KIterable<T>.associateWithTo`, `Kiterable<T>.filterTo`, `KIterable<T>.filterIndexedTo`, `KIterable<T>.filterNotTo`, `KIterable<T>.filterNotNullTo` , `KIterable<T>.groupByTo` ,`KMap<T>.mapKeysTo` ,`KMap<T>.mapValuesTo`, `KIterable.toCollection` did not compile when called directly due to [dart-lang/sdk/issues/35518](https://github.com/dart-lang/sdk/issues/35518). The type of `destination` of those methods has been changed to a dynamic type (i.e. `KMutableList<T>` -> `KMutableList<dynamic>`). It will now be checked at runtime. This has one advantage: It allows to pass in contravariant types.
- #37 `KCollection.random` now optionally accepts a `Random` as argument which can be seeded as you want
- #39 `KList.removeAt` now throws `IndexOutOfBoundsException` when `index` is not valid
- #18 `KCollection`s `addAll`, `removeAll` and `retainAll` now receive `KIterable` as parameter, was `KCollection`

### Documentation changes

- #19 `KIterable.any` document return value when called without `predicate`
- #51 Document expected type of now dynamically typed `KIterable<T>.associateWithTo`, `Kiterable<T>.filterTo`, `KIterable<T>.filterIndexedTo`, `KIterable<T>.filterNotTo`, `KIterable<T>.filterNotNullTo` , `KIterable<T>.groupByTo` ,`KMap<T>.mapKeysTo` ,`KMap<T>.mapValuesTo`, `KIterable.toCollection` 

### Other changes

- Added a **lot of tests** #19, #27, #32, #33, #34, #35, #39, #40, #41, #42, #43, #45, 
- #48, #49, #50, Activated many lint checks 
- #25 `tool/run_coverage_locally.sh` now installs deps only when not installed and prints resulting HTML report path




## 0.2.0

[diff v0.1.0...v0.2.0](https://github.com/passsy/dart_kollection/compare/v0.1.0...v0.2.0)

### Behavior change
- #6 Breaking: `KMutableIterator.remove` now throws `UnimplementedError` because of bug #5

### API changes
- #1 Add `Set<T> get set` returning the internal dart set
- #1 Add `Map<K, V> get map` returning the intenral dart set
- #7 Add `KMap.toMap` and `KMap.toMutableMap`
- #8 Add `KMap.isNotEmpty`
- 3e3228e Add `KMap.toString()`
- #9 Add `Map.plus`, `Map.minus` and  `operator +(KMap<K, V> map)`, `operator -(K key)`
- #12 Remove const constructors from collection interfaces
- #13 Remove default implementations from collection interfaces

### Documentation changes
- #15 Add documentation for `compareBy` and `compareByDescending`

### Other changes
- #2 Travis CI #2
- #3, #4 Code coverage
- #10 Test `KMutableList.fill`
- #11 Test `KPair`, `KTriple`
- #14 Test Exceptions
- #15 Test Comparators `naturalOrder()`, `reverseOrder()`
- #15 Test `reverse(Comparator)` util function
- 6dd0d85 Reformatted with dartfmt (80 chars) 


## 0.1.0

Initial release for 

- `KList`/`KMutableList`
- `KSet`/`KMutableSet`
- `KMap`/`KMutableMap`

with tons of extensions waiting for you to use them!