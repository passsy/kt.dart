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

### Methods

#### `KIterable` Extensions

```dart
iter → Iterable<T>
iterator() → KIterator<T>
all(bool Function(T element) predicate) → bool
any([bool Function(T element) predicate]) → bool
asIterable() → KIterable<T>
associate<K, V>(KPair<K, V> Function(T) transform) → KMap<K, V>
associateBy<K>(K Function(T) keySelector) → KMap<K, T>
associateByTransform<K, V>(K Function(T) keySelector, V Function(T) valueTransform) → KMap<K, V>
associateByTo<K, V, M extends KMutableMap<K, V>>(M destination, K Function(T) keySelector, [V Function(T) valueTransform]) → M
associateTo<K, V, M extends KMutableMap<K, V>>(M destination, KPair<K, V> Function(T) transform) → M
associateWith<V>(V Function(T) valueSelector) → KMap<T, V>
associateWithTo<V, M extends KMutableMap<dynamic, dynamic>>(M destination, V Function(T) valueSelector) → M
averageBy(num Function(T) selector) → double
chunked(int size) → KList<KList<T>>
chunkedTransform<R>(int size, R Function(KList<T>) transform) → KList<R>
contains(T element) → bool
count([bool Function(T) predicate]) → int
distinct() → KList<T>
distinctBy<K>(K Function(T) selector) → KList<T>
drop(int n) → KList<T>
dropWhile(bool Function(T) predicate) → KList<T>
elementAt(int index) → T
elementAtOrElse(int index, T Function(int) defaultValue) → T
elementAtOrNull(int index) → T
filter(bool Function(T) predicate) → KList<T>
filterIndexed(bool Function(int index, T) predicate) → KList<T>
filterIndexedTo<C extends KMutableCollection<dynamic>>(C destination, bool Function(int index, T) predicate) → C
filterIsInstance<R>() → KList<R>
filterNot(bool Function(T) predicate) → KList<T>
filterNotNull() → KList<T>
filterNotNullTo<C extends KMutableCollection<dynamic>>(C destination) → C
filterNotTo<C extends KMutableCollection<dynamic>>(C destination, bool Function(T) predicate) → C
filterTo<C extends KMutableCollection<dynamic>>(C destination, bool Function(T) predicate) → C
find(bool Function(T) predicate) → T
findLast(bool Function(T) predicate) → T
first([bool Function(T) predicate]) → T
firstOrNull([bool Function(T) predicate]) → T
flatMap<R>(KIterable<R> Function(T) transform) → KList<R>
flatMapTo<R, C extends KMutableCollection<R>>(C destination, KIterable<R> Function(T) transform) → C
fold<R>(R initial, R Function(R acc, T) operation) → R
foldIndexed<R>(R initial, R Function(int index, R acc, T) operation) → R
forEach(void Function(T element) action) → void
forEachIndexed(void Function(int index, T element) action) → void
groupBy<K>(K Function(T) keySelector) → KMap<K, KList<T>>
groupByTransform<K, V>(K Function(T) keySelector, V Function(T) valueTransform) → KMap<K, KList<V>>
groupByTo<K, M extends KMutableMap<K, KMutableList<dynamic>>>(M destination, K Function(T) keySelector) → M
groupByToTransform<K, V, M extends KMutableMap<K, KMutableList<V>>>(M destination, K Function(T) keySelector, V Function(T) valueTransform) → M
indexOf(T element) → int
indexOfFirst(bool Function(T) predicate) → int
indexOfLast(bool Function(T) predicate) → int
intersect(KIterable<T> other) → KSet<T>
joinToString({String separator = ", ", String prefix = "", String postfix = "", int limit = -1, String truncated = "...", String Function(T) transform}) → String
last([bool Function(T) predicate]) → T
lastIndexOf(T element) → int
lastOrNull([bool Function(T) predicate]) → T
map<R>(R Function(T) transform) → KList<R>
mapIndexed<R>(R Function(int index, T) transform) → KList<R>
mapIndexedNotNull<R>(R Function(int index, T) transform) → KList<R>
mapIndexedNotNullTo<R, C extends KMutableCollection<R>>(C destination, R Function(int index, T) transform) → C
mapIndexedTo<R, C extends KMutableCollection<R>>(C destination, R Function(int index, T) transform) → C
mapNotNull<R>(R Function(T) transform) → KList<R>
mapNotNullTo<R, C extends KMutableCollection<R>>(C destination, R Function(T) transform) → C
mapTo<R, C extends KMutableCollection<R>>(C destination, R Function(T) transform) → C
max() → num
maxBy<R extends Comparable<R>>(R Function(T) selector) → T
maxWith(Comparator<T> comparator) → T
min() → num
minus(KIterable<T> elements) → KList<T>
-(KIterable<T> elements) → KList<T>
minusElement(T element) → KList<T>
minBy<R extends Comparable<R>>(R Function(T) selector) → T
minWith(Comparator<T> comparator) → T
none([bool Function(T) predicate]) → bool
onEach(void Function(T) action) → void
partition(bool Function(T) predicate) → KPair<KList<T>, KList<T>>
plus(KIterable<T> elements) → KList<T>
+(KIterable<T> elements) → KList<T>
plusElement(T element) → KList<T>
reduce<S>(S Function(S acc, T) operation) → S
reduceIndexed<S>(S Function(int index, S acc, T) operation) → S
requireNoNulls() → KIterable<T>
reversed() → KList<T>
single([bool Function(T) predicate]) → T
singleOrNull([bool Function(T) predicate]) → T
sorted() → KList<T>
sortedBy<R extends Comparable<R>>(R Function(T) selector) → KList<T>
sortedByDescending<R extends Comparable<R>>(R Function(T) selector) → KList<T>
sortedDescending() → KList<T>
sortedWith(Comparator<T> comparator) → KList<T>
subtract(KIterable<T> other) → KSet<T>
sum() → num
sumBy(int Function(T) selector) → int
sumByDouble(double Function(T) selector) → double
take(int n) → KList<T>
toCollection<C extends KMutableCollection<dynamic>>(C destination) → C
toHashSet() → KMutableSet<T>
toList() → KList<T>
toMutableList() → KMutableList<T>
toMutableSet() → KMutableSet<T>
toSet() → KSet<T>
union(KIterable<T> other) → KSet<T>
windowed(int size, {int step = 1, bool partialWindows = false}) → KList<KList<T>>
windowedTransform<R>(int size, R Function(KList<T>) transform, {int step = 1, bool partialWindows = false}) → KList<R>
zip<R>(KIterable<R> other) → KList<KPair<T, R>>
zipTransform<R, V>(KIterable<R> other, V Function(T a, R b) transform) → KList<V>
zipWithNext<R>() → KList<KPair<T, T>>
zipWithNextTransform<R>(R Function(T a, T b) transform) → KList<R>
```

#### `KMutableIterable` Extensions
```dart
iterator() → KMutableIterator<T>
removeAllWhere(bool Function(T) predicate) → bool
retainAllWhere(bool Function(T) predicate) → bool
```

#### `KList` Extensions
```dart
list → List<T>
size → int
isEmpty() → bool
contains(T element) → bool
iterator() → KIterator<T>
containsAll(KCollection<T> elements) → bool
get(int index) → T
[](int index) → T
indexOf(T element) → int
lastIndexOf(T element) → int
listIterator([int index = 0]) → KListIterator<T>
subList(int fromIndex, int toIndex) → KList<T>
dropLast(int n) → KList<T>
dropLastWhile(bool Function(T) predicate) → KList<T>
elementAt(int index) → T
elementAtOrElse(int index, T defaultValue(int index)) → T
elementAtOrNull(int index) → T
first([bool Function(T) predicate]) → T
foldRight<R>(R initial, R Function(T, R acc) operation) → R
foldRightIndexed<R>(R initial, R Function(int index, T, R acc) operation) → R
getOrElse(int index, T Function(int) defaultValue) → T
getOrNull(int index) → T
last([bool Function(T) predicate]) → T
lastIndex → int
reduceRight<S>(S Function(T, S acc) operation) → S
reduceRightIndexed<S>(S Function(int index, T, S acc) operation) → S
slice(KIterable<int> indices) → KList<T>
```

#### `KListMutable` Extensions
```dart
add(T element) → bool
remove(T element) → bool
addAll(KIterable<T> elements) → bool
addAllAt(int index, KCollection<T> elements) → bool
removeAll(KIterable<T> elements) → bool
retainAll(KIterable<T> elements) → bool
clear() → void
set(int index, T element) → T
[]=(int index, T element) → void
addAt(int index, T element) → void
removeAt(int index) → T
listIterator([int index = 0]) → KMutableListIterator<T>
subList(int fromIndex, int toIndex) → KMutableList<T>
fill(T value) → void
reverse() → void
sortBy<R extends Comparable<R>>(R Function(T) selector) → void
sortByDescending<R extends Comparable<R>>(R Function(T) selector) → void
sortWith(Comparator<T> comparator) → void
swap(int indexA, int indexB) → void
```

#### `KSet` Extensions
```dart
set → Set<T>
size → int
isEmpty() → bool
contains(T element) → bool
containsAll(KCollection<T> elements) → bool
iterator() → KIterator<T>
```

#### `KSetMutable` Extensions
```dart
iterator() → KMutableIterator<T>
add(T element) → bool
remove(T element) → bool
addAll(KIterable<T> elements) → bool
removeAll(KIterable<T> elements) → bool
retainAll(KIterable<T> elements) → bool
clear() → void
```

#### `KMap` Extensions
```dart
map → Map<K, V>
size → int
isEmpty() → bool
containsKey(K key) → bool
containsValue(V value) → bool
get(K key) → V
[](K key) → V
getOrDefault(K key, V defaultValue) → V
keys → KSet<K>
values → KCollection<V>
entries → KSet<KMapEntry<K, V>>
filter(bool Function(KMapEntry<K, V> entry) predicate) → KMap<K, V>
filterTo<M extends KMutableMap<dynamic, dynamic>>(M destination, bool Function(KMapEntry<K, V> entry) predicate) → M
filterNot(bool Function(KMapEntry<K, V> entry) predicate) → KMap<K, V>
filterNotTo<M extends KMutableMap<dynamic, dynamic>>(M destination, bool Function(KMapEntry<K, V> entry) predicate) → M
getOrElse(K key, V Function() defaultValue) → V
getValue(K key) → V
iterator() → KIterator<KMapEntry<K, V>>
isNotEmpty() → bool
mapKeys<R>(R Function(KMapEntry<K, V>) transform) → KMap<R, V>
mapKeysTo<R, M extends KMutableMap<dynamic, dynamic>>(M destination, R Function(KMapEntry<K, V> entry) transform) → M
mapValues<R>(R Function(KMapEntry<K, V>) transform) → KMap<K, R>
mapValuesTo<R, M extends KMutableMap<dynamic, dynamic>>(M destination, R Function(KMapEntry<K, V> entry) transform) → M
minus(K key) → KMap<K, V>
-(K key) → KMap<K, V>
plus(KMap<K, V> map) → KMap<K, V>
+(KMap<K, V> map) → KMap<K, V>
toMap() → KMap<K, V>
toMutableMap() → KMutableMap<K, V>
```

#### `KMapMutable` Extensions
```dart
put(K key, V value) → V
[]=(K key, V value) → void
remove(K key) → V
removeMapping(K key, V value) → bool
putAll(KMap<K, V> from) → void
clear() → void
keys → KMutableSet<K>
values → KMutableCollection<V>
entries → KMutableSet<KMutableMapEntry<K, V>>
getOrPut(K key, V Function() defaultValue) → V
iterator() → KMutableIterator<KMutableMapEntry<K, V>>
putAllPairs(KIterable<KPair<K, V>> pairs) → void
putIfAbsent(K key, V value) → V
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
