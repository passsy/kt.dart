// ignore_for_file: avoid_print, unused_result
import "package:kt_dart/kt.dart";

void main() {
  /// Kotlin like, function based syntax

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

  /// Dart like, constructor based syntax

  /// List
  // Create immutable lists
  const KtList<int>.empty();
  KtList.of(1, 2, 3, 4, 5);
  KtList.from([1, 2, 3, 4, 5]);

  // Create mutable lists
  KtMutableList<int>.empty();
  KtMutableList.of(1, 2, 3, 4, 5);
  KtMutableList.from([1, 2, 3, 4, 5]);

  /// Set
  // Create immutable sets
  const KtSet<int>.empty();
  KtSet.of(1, 2, 3, 4, 5);
  KtSet.from([1, 2, 3, 4, 5]);

  // Create a mutable set which keeps the order of the items
  KtMutableSet<int>.empty();
  KtMutableSet.of(1, 2, 3, 4, 5);
  KtMutableSet.from([1, 2, 3, 4, 5]);

  // Create mutable, unordered hash-table based set
  KtHashSet<int>.empty();
  KtHashSet.of(1, 2, 3, 4, 5);
  KtHashSet.from([1, 2, 3, 4, 5]);

  // Create a mutable set which keeps the order of the items
  KtLinkedSet<int>.empty();
  KtLinkedSet.of(1, 2, 3, 4, 5);
  KtLinkedSet.from([1, 2, 3, 4, 5]);

  /// Map
  // Create immutable maps
  const KtMap.empty();
  KtMap.from({1: "a", 2: "b"});

  // Create mutable maps
  KtMutableMap<int, String>.empty();
  KtMutableMap.from({1: "a", 2: "b"});

  // Create mutable maps without specified order when iterating over items
  KtHashMap<int, String>.empty();
  KtHashMap.from({1: "a", 2: "b"});

  // Create mutable maps which keep the order of the items
  KtLinkedMap<int, String>.empty();
  KtLinkedMap.from({1: "a", 2: "b"});

  print("Everything works!");
}
