import 'package:dart_kollection/dart_kollection.dart';

void main() {
  list();
  set();
  map();
  print("Everything works!");
}

void list() {
  emptyList<int>();
  listOf(1, 2, 3, 4, 5);
  listFrom([1, 2, 3, 4, 5]);

  mutableListOf(1, 2, 3, 4, 5);
  mutableListFrom([1, 2, 3, 4, 5]);

  KList<int>.empty();
  KList.of(1, 2, 3, 4, 5);
  KList.from([1, 2, 3, 4, 5]);

  KMutableList<int>.empty();
  KMutableList.of(1, 2, 3, 4, 5);
  KMutableList.from([1, 2, 3, 4, 5]);
}

void set() {
  emptySet<int>();
  setOf(1, 2, 3, 4, 5);
  setFrom([1, 2, 3, 4, 5]);

  KSet<int>.empty();
  KSet.of(1, 2, 3, 4, 5);
  KSet.from([1, 2, 3, 4, 5]);

  KHashSet<int>.empty();
  KHashSet.of(1, 2, 3, 4, 5);
  KHashSet.from([1, 2, 3, 4, 5]);

  KLinkedSet<int>.empty();
  KLinkedSet.of(1, 2, 3, 4, 5);
  KLinkedSet.from([1, 2, 3, 4, 5]);
}

void map() {
  emptyMap<int, String>();
  mapFrom({1: "a", 2: "b"});

  KMutableMap<int, String>.empty();
  KMutableMap.from({1: "a", 2: "b"});

  KHashMap<int, String>.empty();
  KHashMap.from({1: "a", 2: "b"});

  KLinkedMap<int, String>.empty();
  KLinkedMap.from({1: "a", 2: "b"});
}
