import 'package:dart_kollection/dart_kollection.dart';

void main() {
  list();
  set();
  map();
  print("Everything works!");
}

void list() {
  // List of
  final kListOf = listOf(1, 2, 3, 4, 5);
  final dListOf = KList.of(1, 2, 3, 4, 5);
  assert(kListOf == dListOf);

  // List from
  final kListFrom = listFrom([1, 2, 3, 4, 5]);
  final dListFrom = KList.from([1, 2, 3, 4, 5]);
  assert(kListFrom == dListFrom);

  // MutableList of
  final kMutableListOf = mutableListOf(1, 2, 3, 4, 5);
  final dMutableListOf = KMutableList.of(1, 2, 3, 4, 5);
  assert(kMutableListOf == dMutableListOf);

  // MutableList from
  final kMutableListFrom = mutableListFrom([1, 2, 3, 4, 5]);
  final dMutableListFrom = KMutableList.from([1, 2, 3, 4, 5]);
  assert(kMutableListFrom == dMutableListFrom);
}

void set() {
  // Set of
  final kSetOf = setOf(1, 2, 3, 4, 5);
  final dSetOf = KSet.of(1, 2, 3, 4, 5);
  assert(kSetOf == dSetOf);

  // Set from
  final kSetFrom = setFrom([1, 2, 3, 4, 5]);
  final dSetFrom = KSet.from([1, 2, 3, 4, 5]);
  assert(kSetFrom == dSetFrom);

  // LinkedSet from
  final kLinkedSetFrom = linkedSetFrom([1, 2, 3, 4, 5]);
  final dLinkedSetFrom = KLinkedSet.from([1, 2, 3, 4, 5]);
  assert(kLinkedSetFrom == dLinkedSetFrom);

  // HashSet from
  final kHashSetFrom = hashSetFrom([1, 2, 3, 4, 5]);
  final dHashSetFrom = KHashSet.from([1, 2, 3, 4, 5]);
  assert(kHashSetFrom == dHashSetFrom);
}

void map() {
  // Map from
  final kMap = mapFrom({1: "a", 2: "b"});
  final dMap = KMap.from({1: "a", 2: "b"});
  assert(kMap == dMap);

  // HashMap from
  final kHashMap = hashMapFrom({1: "a", 2: "b"});
  final dHashMap = KHashMap.from({1: "a", 2: "b"});
  assert(kHashMap == dHashMap);

  // LinkedHashMap from
  final kLinkedHashMap = linkedMapFrom({1: "a", 2: "b"});
  final dLinkedHashMap = KLinkedMap.from({1: "a", 2: "b"});
  assert(kLinkedHashMap == dLinkedHashMap);

  // MutableMap from
  final kMutableMap = mutableMapFrom({1: "a", 2: "b"});
  final dMutableMap = KMutableMap.from({1: "a", 2: "b"});
  assert(kMutableMap == dMutableMap);
}
