import 'dart:collection';

import 'package:kotlin_dart/kotlin.dart';

/**
 * Returns a new read-only list of given elements.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [listFrom]
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtList<T> listOf<T>(
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
    KtList.of(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);

/**
 * Returns a new read-only list based on [elements].
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtList<T> listFrom<T>([Iterable<T> elements = const []]) =>
    KtList.from(elements);

/**
 * Returns an empty read-only list.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtList<T> emptyList<T>() => KtList.empty();

/**
 * Returns a new mutable list of given elements.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [mutableListFrom]
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtMutableList<T> mutableListOf<T>(
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
  return KtMutableList.of(
      arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

/**
 * Returns a new mutable list based on [elements].
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtMutableList<T> mutableListFrom<T>([Iterable<T> elements = const []]) =>
    KtMutableList.from(elements);

/**
 * Returns an immutable map, mapping only the specified key to the
 * specified value.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtMap<K, V> mapFrom<K, V>([Map<K, V> map = const {}]) => KtMap.from(map);

/**
 * Returns an empty read-only map of specified type.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtMap<K, V> emptyMap<K, V>() => KtMap.empty();

/**
 * Returns a new [MutableMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 *
 * If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
 *
 * Entries of the map are iterated in the order they were specified.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtMutableMap<K, V> mutableMapFrom<K, V>([Map<K, V> map = const {}]) =>
    KtMutableMap.from(map);

/**
 * Returns a new [HashMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtHashMap<K, V> hashMapFrom<K, V>([Map<K, V> map = const {}]) =>
    KtHashMap.from(map);

/**
 * Returns a new [LinkedHashMap] with the specified contents, given as a list of pairs
 * where the first component is the key and the second is the value.
 *
 * If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
 *
 * Entries of the map are iterated in the order they were specified.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtLinkedMap<K, V> linkedMapFrom<K, V>([Map<K, V> map = const {}]) =>
    KtLinkedMap.from(map);

/**
 * Returns a new read-only set with the given elements.
 * Elements of the set are iterated in the order they were specified.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [setFrom]
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtSet<T> setOf<T>(
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
    KtSet.of(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);

/**
 * Returns a new read-only set based on [elements].
 * Elements of the set are iterated in the order they were specified.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtSet<T> setFrom<T>([Iterable<T> elements = const []]) => KtSet.from(elements);

/**
 * Returns an empty read-only set.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtSet<T> emptySet<T>() => KtSet.empty();

/**
 * Returns a new [KtMutableSet] based on [LinkedHashSet] with the given elements.
 * Elements of the set are iterated in the order they were specified.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [linkedSetFrom]
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtMutableSet<T> mutableSetOf<T>(
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
  return KtMutableSet.of(
      arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

/**
 * Returns a new [LinkedHashSet] based on [elements].
 * Elements of the set are iterated in the order they were specified.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtMutableSet<T> mutableSetFrom<T>([Iterable<T> elements = const []]) =>
    KtMutableSet.from(elements);

/**
 * Returns a new [KtMutableSet] based on [LinkedHashSet] with the given elements.
 * Elements of the set are iterated in the order they were specified.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [linkedSetFrom]
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtLinkedSet<T> linkedSetOf<T>(
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
  return KtLinkedSet.of(
      arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

/**
 * Returns a new [LinkedHashSet] based on [elements].
 * Elements of the set are iterated in the order they were specified.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtLinkedSet<T> linkedSetFrom<T>([Iterable<T> elements = const []]) =>
    KtLinkedSet.from(elements);

/**
 * Returns a new [KtMutableSet] based on [HashSet] with the given elements.
 * Elements of the set are iterated in unpredictable order.
 *
 * Elements aren't allowed to be `null`. If your list requires `null` values use [hashSetFrom]
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtHashSet<T> hashSetOf<T>(
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
  return KtHashSet.of(
      arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

/**
 * Returns a new [HashSet] based on [elements].
 * Elements of the set are iterated in unpredictable order.
 */
@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
KtMutableSet<T> hashSetFrom<T>([Iterable<T> elements = const []]) =>
    KtHashSet.from(elements);
