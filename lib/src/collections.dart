import 'dart:collection';

import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/map_mutable.dart';
import 'package:dart_kollection/src/k_set_linked.dart';

/**
 * Returns a new read-only list of given elements.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [listFrom]
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
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
        T arg9]) =>
    KList.of(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);

/**
 * Returns a new read-only list based on [elements].
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KList<T> listFrom<T>([Iterable<T> elements = const []]) => KList.from(elements);

/**
 * Returns an empty read-only list.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KList<T> emptyList<T>() => KList.empty();

/**
 * Returns a new mutable list of given elements.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [mutableListFrom]
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
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
  return KMutableList.of(
      arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

/**
 * Returns a new mutable list based on [elements].
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KMutableList<T> mutableListFrom<T>([Iterable<T> elements = const []]) =>
    KMutableList.from(elements);

/**
 * Returns an immutable map, mapping only the specified key to the
 * specified value.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KMap<K, V> mapFrom<K, V>([Map<K, V> map = const {}]) => KMap.from(map);

/**
 * Returns an empty read-only map of specified type.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KMap<K, V> emptyMap<K, V>() => KMap.empty();

/**
 * Returns a new [MutableMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 *
 * If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
 *
 * Entries of the map are iterated in the order they were specified.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KMutableMap<K, V> mutableMapFrom<K, V>([Map<K, V> map = const {}]) =>
    KMutableMap.from(map);

/**
 * Returns a new [HashMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KMutableMap<K, V> hashMapFrom<K, V>([Map<K, V> map = const {}]) =>
    DartMutableMap(HashMap.from(map));

/**
 * Returns a new [LinkedHashMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 *
 * If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
 *
 * Entries of the map are iterated in the order they were specified.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KMutableMap<K, V> linkedMapFrom<K, V>([Map<K, V> map = const {}]) =>
    DartMutableMap(LinkedHashMap.from(map));

/**
 * Returns a new read-only set with the given elements.
 * Elements of the set are iterated in the order they were specified.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [setFrom]
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
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
        T arg9]) =>
    KSet.of(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);

/**
 * Returns a new read-only set based on [elements].
 * Elements of the set are iterated in the order they were specified.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KSet<T> setFrom<T>([Iterable<T> elements = const []]) => KSet.from(elements);

/**
 * Returns an empty read-only set.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KSet<T> emptySet<T>() => KSet.empty();

/**
 * Returns a new [KMutableSet] based on [LinkedHashSet] with the given elements.
 * Elements of the set are iterated in the order they were specified.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [linkedSetFrom]
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KMutableSet<T> mutableSetOf<T>(
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
  return KMutableSet.of(
      arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

/**
 * Returns a new [LinkedHashSet] based on [elements].
 * Elements of the set are iterated in the order they were specified.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KMutableSet<T> mutableSetFrom<T>([Iterable<T> elements = const []]) =>
    KMutableSet.from(elements);

/**
 * Returns a new [KMutableSet] based on [LinkedHashSet] with the given elements.
 * Elements of the set are iterated in the order they were specified.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [linkedSetFrom]
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KLinkedSet<T> linkedSetOf<T>(
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
  return KLinkedSet.of(
      arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

/**
 * Returns a new [LinkedHashSet] based on [elements].
 * Elements of the set are iterated in the order they were specified.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KLinkedSet<T> linkedSetFrom<T>([Iterable<T> elements = const []]) =>
    KLinkedSet.from(elements);

/**
 * Returns a new [KMutableSet] based on [HashSet] with the given elements.
 * Elements of the set are iterated in unpredictable order.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [hashSetFrom]
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KHashSet<T> hashSetOf<T>(
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
  return KHashSet.of(
      arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

/**
 * Returns a new [HashSet] based on [elements].
 * Elements of the set are iterated in unpredictable order.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
KMutableSet<T> hashSetFrom<T>([Iterable<T> elements = const []]) =>
    KHashSet.from(elements);
