# kt.dart - collection

Here is a list of all collection creation APIs.
Both APIs, factory constructor and function based one, **are equally supported.** It only depends on your personal taste.

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