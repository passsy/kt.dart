import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/list.dart';
import 'package:dart_kollection/src/internal/list_empty.dart';
import 'package:dart_kollection/src/internal/map.dart';
import 'package:dart_kollection/src/internal/map_empty.dart';
import 'package:dart_kollection/src/internal/set.dart';
import 'package:dart_kollection/src/internal/set_empty.dart';

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
KList<T> emptyList<T>() => kEmptyList;

/**
 *  Returns an immutable map, mapping only the specified key to the
 * specified value.
 */
KMap<K, V> mapOf<K, V>([Map<K, V> map = const {}]) => DartMap(map);

/**
 * Returns an empty read-only map of specified type.
 */
KMap<K, V> emptyMap<K, V>() => kEmptyMap;

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
KSet<T> emptySet<T>() => kEmptySet;
