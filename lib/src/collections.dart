import 'dart:collection';

import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/list.dart';
import 'package:dart_kollection/src/collection/list_empty.dart';
import 'package:dart_kollection/src/collection/list_mutable.dart';
import 'package:dart_kollection/src/collection/map.dart';
import 'package:dart_kollection/src/collection/map_empty.dart';
import 'package:dart_kollection/src/collection/map_mutable.dart';
import 'package:dart_kollection/src/collection/set.dart';
import 'package:dart_kollection/src/collection/set_empty.dart';
import 'package:dart_kollection/src/collection/set_mutable.dart';

/**
 * Returns a new read-only list of given elements.
 */
KList<T> listOf<T>([Iterable<T> elements = const []]) {
  if (elements.length == 0) return emptyList();
  return DartList(elements);
}

/**
 * Returns an empty read-only list.
 */
KList<T> emptyList<T>() => EmptyList<T>();

/**
 * Returns an empty new [MutableList].
 */
KMutableList<T> mutableListOf<T>([Iterable<T> elements = const []]) => DartMutableList(elements);

/**
 * Returns an immutable map, mapping only the specified key to the
 * specified value.
 */
KMap<K, V> mapOf<K, V>([Map<K, V> map = const {}]) => DartMap(map);

/**
 * Returns an empty read-only map of specified type.
 */
KMap<K, V> emptyMap<K, V>() => EmptyMap<K, V>();

/**
 * Returns a new [MutableMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 *
 * If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
 *
 * Entries of the map are iterated in the order they were specified.
 */
KMutableMap<K, V> mutableMapOf<K, V>([Map<K, V> map = const {}]) => DartMutableMap.noCopy(LinkedHashMap.of(map));

/**
 * Returns a new [HashMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 */
KMutableMap<K, V> hashMapOf<K, V>([Map<K, V> map = const {}]) => DartMutableMap.noCopy(HashMap.of(map));

/**
 * Returns an empty new [HashMap].
 */
KMutableMap<K, V> hashMapFrom<K, V>(KIterable<KPair<K, V>> pairs) {
  var map = DartMutableMap.noCopy(HashMap<K, V>());
  if (pairs != null) {
    map.putAllPairs(pairs);
  }
  return map;
}

/**
 * Returns a new [LinkedHashMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 *
 * If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
 *
 * Entries of the map are iterated in the order they were specified.
 */
KMutableMap<K, V> linkedMapOf<K, V>([Map<K, V> map = const {}]) => DartMutableMap.noCopy(LinkedHashMap.of(map));

/**
 * Returns a new read-only set with the given elements.
 * Elements of the set are iterated in the order they were specified.
 */
KSet<T> setOf<T>([Iterable<T> elements = const []]) {
  if (elements.length == 0) return emptySet();
  return DartSet(elements);
}

/**
 * Returns an empty read-only set.
 */
KSet<T> emptySet<T>() => EmptySet<T>();

KMutableSet<T> linkedSetOf<T>([Iterable<T> elements = const []]) {
  return DartMutableSet.noCopy(LinkedHashSet<T>.of(elements));
}
