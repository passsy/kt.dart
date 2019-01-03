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
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [listFrom]
 */
KList<T> listOf<T>(
    [T arg0,
    T arg1,
    T arg2,
    T arg3,
    T arg4,
    T arg5,
    T arg6,
    T arg7,
    T arg8,
    T arg9]) {
  List<T> args;
  if (arg9 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9];
  } else if (arg8 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8];
  } else if (arg7 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7];
  } else if (arg6 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6];
  } else if (arg5 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5];
  } else if (arg4 != null) {
    args = [arg0, arg1, arg2, arg3, arg4];
  } else if (arg3 != null) {
    args = [arg0, arg1, arg2, arg3];
  } else if (arg2 != null) {
    args = [arg0, arg1, arg2];
  } else if (arg1 != null) {
    args = [arg0, arg1];
  } else if (arg0 != null) {
    args = [arg0];
  } else {
    return emptyList();
  }
  assert(() {
    if (args.contains(null))
      throw ArgumentError("Element at position ${args.indexOf(null)} is null.");
    return true;
  }());
  return DartList(args);
}

/**
 * Returns a new read-only list based on [elements].
 */
KList<T> listFrom<T>([Iterable<T> elements = const []]) {
  if (elements.isEmpty) return emptyList();
  return DartList(elements);
}

/**
 * Returns an empty read-only list.
 */
KList<T> emptyList<T>() => EmptyList<T>();

/**
 * Returns a new mutable list of given elements.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [mutableListFrom]
 */
KMutableList<T> mutableListOf<T>(
    [T arg0,
    T arg1,
    T arg2,
    T arg3,
    T arg4,
    T arg5,
    T arg6,
    T arg7,
    T arg8,
    T arg9]) {
  List<T> args;
  if (arg9 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9];
  } else if (arg8 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8];
  } else if (arg7 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7];
  } else if (arg6 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6];
  } else if (arg5 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5];
  } else if (arg4 != null) {
    args = [arg0, arg1, arg2, arg3, arg4];
  } else if (arg3 != null) {
    args = [arg0, arg1, arg2, arg3];
  } else if (arg2 != null) {
    args = [arg0, arg1, arg2];
  } else if (arg1 != null) {
    args = [arg0, arg1];
  } else if (arg0 != null) {
    args = [arg0];
  } else {
    args = [];
  }
  assert(() {
    if (args.contains(null))
      throw ArgumentError("Element at position ${args.indexOf(null)} is null.");
    return true;
  }());
  return DartMutableList(args);
}

/**
 * Returns a new mutable list based on [elements].
 */
KMutableList<T> mutableListFrom<T>([Iterable<T> elements = const []]) =>
    DartMutableList(elements);

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
KMutableMap<K, V> mutableMapOf<K, V>([Map<K, V> map = const {}]) =>
    DartMutableMap.noCopy(LinkedHashMap.of(map));

/**
 * Returns a new [HashMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 */
KMutableMap<K, V> hashMapOf<K, V>([Map<K, V> map = const {}]) =>
    DartMutableMap.noCopy(HashMap.of(map));

/**
 * Returns a new [LinkedHashMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 *
 * If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
 *
 * Entries of the map are iterated in the order they were specified.
 */
KMutableMap<K, V> linkedMapOf<K, V>([Map<K, V> map = const {}]) =>
    DartMutableMap.noCopy(LinkedHashMap.of(map));

/**
 * Returns a new read-only set with the given elements.
 * Elements of the set are iterated in the order they were specified.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [setFrom]
 */
KSet<T> setOf<T>(
    [T arg0,
    T arg1,
    T arg2,
    T arg3,
    T arg4,
    T arg5,
    T arg6,
    T arg7,
    T arg8,
    T arg9]) {
  List<T> args;
  if (arg9 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9];
  } else if (arg8 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8];
  } else if (arg7 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7];
  } else if (arg6 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6];
  } else if (arg5 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5];
  } else if (arg4 != null) {
    args = [arg0, arg1, arg2, arg3, arg4];
  } else if (arg3 != null) {
    args = [arg0, arg1, arg2, arg3];
  } else if (arg2 != null) {
    args = [arg0, arg1, arg2];
  } else if (arg1 != null) {
    args = [arg0, arg1];
  } else if (arg0 != null) {
    args = [arg0];
  } else {
    args = [];
  }
  assert(() {
    if (args.contains(null))
      throw ArgumentError("Element at position ${args.indexOf(null)} is null.");
    return true;
  }());
  return DartSet(args);
}

/**
 * Returns a new read-only set based on [elements].
 * Elements of the set are iterated in the order they were specified.
 */
KSet<T> setFrom<T>([Iterable<T> elements = const []]) {
  if (elements.isEmpty) return emptySet();
  return DartSet(elements);
}

/**
 * Returns an empty read-only set.
 */
KSet<T> emptySet<T>() => EmptySet<T>();

/**
 * Returns a new [KMutableSet] based on [LinkedHashSet] with the given elements.
 * Elements of the set are iterated in the order they were specified.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [linkedSetFrom]
 */
KMutableSet<T> linkedSetOf<T>(
    [T arg0,
    T arg1,
    T arg2,
    T arg3,
    T arg4,
    T arg5,
    T arg6,
    T arg7,
    T arg8,
    T arg9]) {
  List<T> args;
  if (arg9 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9];
  } else if (arg8 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8];
  } else if (arg7 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7];
  } else if (arg6 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6];
  } else if (arg5 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5];
  } else if (arg4 != null) {
    args = [arg0, arg1, arg2, arg3, arg4];
  } else if (arg3 != null) {
    args = [arg0, arg1, arg2, arg3];
  } else if (arg2 != null) {
    args = [arg0, arg1, arg2];
  } else if (arg1 != null) {
    args = [arg0, arg1];
  } else if (arg0 != null) {
    args = [arg0];
  } else {
    args = [];
  }
  assert(() {
    if (args.contains(null))
      throw ArgumentError("Element at position ${args.indexOf(null)} is null.");
    return true;
  }());
  return DartMutableSet.noCopy(LinkedHashSet<T>.of(args));
}

/**
 * Returns a new [LinkedHashSet] based on [elements].
 * Elements of the set are iterated in the order they were specified.
 */
KMutableSet<T> linkedSetFrom<T>([Iterable<T> elements = const []]) {
  return DartMutableSet.noCopy(LinkedHashSet<T>.of(elements));
}

/**
 * Returns a new [KMutableSet] based on [HashSet] with the given elements.
 * Elements of the set are iterated in unpredictable order.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [hashSetFrom]
 */
KMutableSet<T> hashSetOf<T>(
    [T arg0,
    T arg1,
    T arg2,
    T arg3,
    T arg4,
    T arg5,
    T arg6,
    T arg7,
    T arg8,
    T arg9]) {
  List<T> args;
  if (arg9 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9];
  } else if (arg8 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8];
  } else if (arg7 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7];
  } else if (arg6 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6];
  } else if (arg5 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5];
  } else if (arg4 != null) {
    args = [arg0, arg1, arg2, arg3, arg4];
  } else if (arg3 != null) {
    args = [arg0, arg1, arg2, arg3];
  } else if (arg2 != null) {
    args = [arg0, arg1, arg2];
  } else if (arg1 != null) {
    args = [arg0, arg1];
  } else if (arg0 != null) {
    args = [arg0];
  } else {
    args = [];
  }
  assert(() {
    if (args.contains(null))
      throw ArgumentError("Element at position ${args.indexOf(null)} is null.");
    return true;
  }());
  return DartMutableSet.noCopy(HashSet<T>.of(args));
}

/**
 * Returns a new [HashSet] based on [elements].
 * Elements of the set are iterated in unpredictable order.
 */
KMutableSet<T> hashSetFrom<T>([Iterable<T> elements = const []]) {
  return DartMutableSet.noCopy(HashSet<T>.of(elements));
}
