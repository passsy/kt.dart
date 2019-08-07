import "dart:collection";

import "package:kt_dart/kt.dart";

/// Returns a new read-only list of given elements.
///
/// Elements aren't allowed to be `null`. If your list requires `null` values use [listFrom]
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

/// Returns a new read-only list based on [elements].
KtList<T> listFrom<T>([Iterable<T> elements = const []]) =>
    KtList.from(elements);

/// Returns an empty read-only list.
KtList<T> emptyList<T>() => KtList<T>.empty();

/// Returns a new mutable list of given elements.
///
/// Elements aren't allowed to be `null`. If your list requires `null` values use [mutableListFrom]
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

/// Returns a new mutable list based on [elements].
KtMutableList<T> mutableListFrom<T>([Iterable<T> elements = const []]) =>
    KtMutableList.from(elements);

/// Returns an immutable map, mapping only the specified key to the
/// specified value.
KtMap<K, V> mapFrom<K, V>([Map<K, V> map = const {}]) => KtMap.from(map);

/// Returns an empty read-only map of specified type.
KtMap<K, V> emptyMap<K, V>() => KtMap<K, V>.empty();

/// Returns a new [KtMutableMap] with the specified contents, given as a list of pairs
/// where the first component is the key and the second is the value.
///
/// If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
///
/// Entries of the map are iterated in the order they were specified.
KtMutableMap<K, V> mutableMapFrom<K, V>([Map<K, V> map = const {}]) =>
    KtMutableMap.from(map);

/// Returns a new [HashMap] with the specified contents, given as a list of pairs
/// where the first component is the key and the second is the value.
KtHashMap<K, V> hashMapFrom<K, V>([Map<K, V> map = const {}]) =>
    KtHashMap.from(map);

/// Returns a new [LinkedHashMap] with the specified contents, given as a list of pairs
/// where the first component is the key and the second is the value.
///
/// If multiple pairs have the same key, the resulting map will contain the value from the last of those pairs.
///
/// Entries of the map are iterated in the order they were specified.
KtLinkedMap<K, V> linkedMapFrom<K, V>([Map<K, V> map = const {}]) =>
    KtLinkedMap.from(map);

/// Returns a new read-only set with the given elements.
/// Elements of the set are iterated in the order they were specified.
///
/// Elements aren't allowed to be `null`. If your list requires `null` values use [setFrom]
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

/// Returns a new read-only set based on [elements].
/// Elements of the set are iterated in the order they were specified.
KtSet<T> setFrom<T>([Iterable<T> elements = const []]) => KtSet.from(elements);

/// Returns an empty read-only set.
KtSet<T> emptySet<T>() => KtSet<T>.empty();

/// Returns a new [KtMutableSet] based on [LinkedHashSet] with the given elements.
/// Elements of the set are iterated in the order they were specified.
///
/// Elements aren't allowed to be `null`. If your list requires `null` values use [linkedSetFrom]
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

/// Returns a new [LinkedHashSet] based on [elements].
/// Elements of the set are iterated in the order they were specified.
KtMutableSet<T> mutableSetFrom<T>([Iterable<T> elements = const []]) =>
    KtMutableSet.from(elements);

/// Returns a new [KtMutableSet] based on [LinkedHashSet] with the given elements.
/// Elements of the set are iterated in the order they were specified.
///
/// Elements aren't allowed to be `null`. If your list requires `null` values use [linkedSetFrom]
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

/// Returns a new [LinkedHashSet] based on [elements].
/// Elements of the set are iterated in the order they were specified.
KtLinkedSet<T> linkedSetFrom<T>([Iterable<T> elements = const []]) =>
    KtLinkedSet.from(elements);

/// Returns a new [KtMutableSet] based on [HashSet] with the given elements.
/// Elements of the set are iterated in unpredictable order.
///
/// Elements aren't allowed to be `null`. If your list requires `null` values use [hashSetFrom]
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

/// Returns a new [HashSet] based on [elements].
/// Elements of the set are iterated in unpredictable order.
KtMutableSet<T> hashSetFrom<T>([Iterable<T> elements = const []]) =>
    KtHashSet.from(elements);
