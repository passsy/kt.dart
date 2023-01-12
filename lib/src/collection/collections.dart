import "dart:collection";

import "package:kt_dart/kt.dart";
import 'package:kt_dart/src/util/arguments.dart';
import 'package:meta/meta.dart';

/// Returns a new read-only list of given elements.
///
/// `null` is a valid argument
@useResult
KtList<T> Function<T>(
    [T arg0,
    T arg1,
    T arg2,
    T arg3,
    T arg4,
    T arg5,
    T arg6,
    T arg7,
    T arg8,
    T arg9]) listOf = _listOf;

/// Implementation of [listOf] which creates a list of provided arguments
/// where `T` might be `T` or `null`.
@useResult
KtList<T> _listOf<T>([
  Object? arg0 = defaultArgument,
  Object? arg1 = defaultArgument,
  Object? arg2 = defaultArgument,
  Object? arg3 = defaultArgument,
  Object? arg4 = defaultArgument,
  Object? arg5 = defaultArgument,
  Object? arg6 = defaultArgument,
  Object? arg7 = defaultArgument,
  Object? arg8 = defaultArgument,
  Object? arg9 = defaultArgument,
]) {
  return KtList.from([
    if (arg0 != defaultArgument) arg0 as T,
    if (arg1 != defaultArgument) arg1 as T,
    if (arg2 != defaultArgument) arg2 as T,
    if (arg3 != defaultArgument) arg3 as T,
    if (arg4 != defaultArgument) arg4 as T,
    if (arg5 != defaultArgument) arg5 as T,
    if (arg6 != defaultArgument) arg6 as T,
    if (arg7 != defaultArgument) arg7 as T,
    if (arg8 != defaultArgument) arg8 as T,
    if (arg9 != defaultArgument) arg9 as T,
  ]);
}

/// Returns a new read-only list based on [elements].
@useResult
KtList<T> listFrom<T>([Iterable<T> elements = const []]) =>
    KtList.from(elements);

/// Returns an empty read-only list.
@useResult
KtList<T> emptyList<T>() => KtList<T>.empty();

/// Returns a new mutable list of given elements.
///
/// `null` is a valid argument
KtMutableList<T> Function<T>(
    [T arg0,
    T arg1,
    T arg2,
    T arg3,
    T arg4,
    T arg5,
    T arg6,
    T arg7,
    T arg8,
    T arg9]) mutableListOf = _mutableListOf;

KtMutableList<T> _mutableListOf<T>([
  Object? arg0 = defaultArgument,
  Object? arg1 = defaultArgument,
  Object? arg2 = defaultArgument,
  Object? arg3 = defaultArgument,
  Object? arg4 = defaultArgument,
  Object? arg5 = defaultArgument,
  Object? arg6 = defaultArgument,
  Object? arg7 = defaultArgument,
  Object? arg8 = defaultArgument,
  Object? arg9 = defaultArgument,
]) {
  return KtMutableList.from([
    if (arg0 != defaultArgument) arg0 as T,
    if (arg1 != defaultArgument) arg1 as T,
    if (arg2 != defaultArgument) arg2 as T,
    if (arg3 != defaultArgument) arg3 as T,
    if (arg4 != defaultArgument) arg4 as T,
    if (arg5 != defaultArgument) arg5 as T,
    if (arg6 != defaultArgument) arg6 as T,
    if (arg7 != defaultArgument) arg7 as T,
    if (arg8 != defaultArgument) arg8 as T,
    if (arg9 != defaultArgument) arg9 as T,
  ]);
}

/// Returns a new mutable list based on [elements].
KtMutableList<T> mutableListFrom<T>([Iterable<T> elements = const []]) =>
    KtMutableList.from(elements);

/// Returns an immutable map, mapping only the specified key to the
/// specified value.
@useResult
KtMap<K, V> mapFrom<K, V>([Map<K, V> map = const {}]) => KtMap.from(map);

/// Returns an empty read-only map of specified type.
@useResult
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
/// `null` is a valid argument
@useResult
KtSet<T> Function<T>([
  T arg0,
  T arg1,
  T arg2,
  T arg3,
  T arg4,
  T arg5,
  T arg6,
  T arg7,
  T arg8,
  T arg9,
]) setOf = _setOf;

KtSet<T> _setOf<T>([
  Object? arg0 = defaultArgument,
  Object? arg1 = defaultArgument,
  Object? arg2 = defaultArgument,
  Object? arg3 = defaultArgument,
  Object? arg4 = defaultArgument,
  Object? arg5 = defaultArgument,
  Object? arg6 = defaultArgument,
  Object? arg7 = defaultArgument,
  Object? arg8 = defaultArgument,
  Object? arg9 = defaultArgument,
]) {
  return KtSet.from([
    if (arg0 != defaultArgument) arg0 as T,
    if (arg1 != defaultArgument) arg1 as T,
    if (arg2 != defaultArgument) arg2 as T,
    if (arg3 != defaultArgument) arg3 as T,
    if (arg4 != defaultArgument) arg4 as T,
    if (arg5 != defaultArgument) arg5 as T,
    if (arg6 != defaultArgument) arg6 as T,
    if (arg7 != defaultArgument) arg7 as T,
    if (arg8 != defaultArgument) arg8 as T,
    if (arg9 != defaultArgument) arg9 as T,
  ]);
}

/// Returns a new read-only set based on [elements].
/// Elements of the set are iterated in the order they were specified.
@useResult
KtSet<T> setFrom<T>([Iterable<T> elements = const []]) => KtSet.from(elements);

/// Returns an empty read-only set.
@useResult
KtSet<T> emptySet<T>() => KtSet<T>.empty();

/// Returns a new [KtMutableSet] based on [LinkedHashSet] with the given elements.
/// Elements of the set are iterated in the order they were specified.
///
/// `null` is a valid argument
KtMutableSet<T> Function<T>([
  T arg0,
  T arg1,
  T arg2,
  T arg3,
  T arg4,
  T arg5,
  T arg6,
  T arg7,
  T arg8,
  T arg9,
]) mutableSetOf = _mutableSetOf;

KtMutableSet<T> _mutableSetOf<T>([
  Object? arg0 = defaultArgument,
  Object? arg1 = defaultArgument,
  Object? arg2 = defaultArgument,
  Object? arg3 = defaultArgument,
  Object? arg4 = defaultArgument,
  Object? arg5 = defaultArgument,
  Object? arg6 = defaultArgument,
  Object? arg7 = defaultArgument,
  Object? arg8 = defaultArgument,
  Object? arg9 = defaultArgument,
]) {
  return KtMutableSet.from([
    if (arg0 != defaultArgument) arg0 as T,
    if (arg1 != defaultArgument) arg1 as T,
    if (arg2 != defaultArgument) arg2 as T,
    if (arg3 != defaultArgument) arg3 as T,
    if (arg4 != defaultArgument) arg4 as T,
    if (arg5 != defaultArgument) arg5 as T,
    if (arg6 != defaultArgument) arg6 as T,
    if (arg7 != defaultArgument) arg7 as T,
    if (arg8 != defaultArgument) arg8 as T,
    if (arg9 != defaultArgument) arg9 as T,
  ]);
}

/// Returns a new [LinkedHashSet] based on [elements].
/// Elements of the set are iterated in the order they were specified.
KtMutableSet<T> mutableSetFrom<T>([Iterable<T> elements = const []]) =>
    KtMutableSet.from(elements);

/// Returns a new [KtMutableSet] based on [LinkedHashSet] with the given elements.
/// Elements of the set are iterated in the order they were specified.
///
/// `null` is a valid argument
KtLinkedSet<T> Function<T>([
  T arg0,
  T arg1,
  T arg2,
  T arg3,
  T arg4,
  T arg5,
  T arg6,
  T arg7,
  T arg8,
  T arg9,
]) linkedSetOf = _linkedSetOf;

KtLinkedSet<T> _linkedSetOf<T>([
  Object? arg0 = defaultArgument,
  Object? arg1 = defaultArgument,
  Object? arg2 = defaultArgument,
  Object? arg3 = defaultArgument,
  Object? arg4 = defaultArgument,
  Object? arg5 = defaultArgument,
  Object? arg6 = defaultArgument,
  Object? arg7 = defaultArgument,
  Object? arg8 = defaultArgument,
  Object? arg9 = defaultArgument,
]) {
  return KtLinkedSet.from([
    if (arg0 != defaultArgument) arg0 as T,
    if (arg1 != defaultArgument) arg1 as T,
    if (arg2 != defaultArgument) arg2 as T,
    if (arg3 != defaultArgument) arg3 as T,
    if (arg4 != defaultArgument) arg4 as T,
    if (arg5 != defaultArgument) arg5 as T,
    if (arg6 != defaultArgument) arg6 as T,
    if (arg7 != defaultArgument) arg7 as T,
    if (arg8 != defaultArgument) arg8 as T,
    if (arg9 != defaultArgument) arg9 as T,
  ]);
}

/// Returns a new [LinkedHashSet] based on [elements].
/// Elements of the set are iterated in the order they were specified.
KtLinkedSet<T> linkedSetFrom<T>([Iterable<T> elements = const []]) =>
    KtLinkedSet.from(elements);

/// Returns a new [KtMutableSet] based on [HashSet] with the given elements.
/// Elements of the set are iterated in unpredictable order.
///
/// `null` is a valid argument
KtHashSet<T> Function<T>([
  T arg0,
  T arg1,
  T arg2,
  T arg3,
  T arg4,
  T arg5,
  T arg6,
  T arg7,
  T arg8,
  T arg9,
]) hashSetOf = _hashSetOf;

KtHashSet<T> _hashSetOf<T>([
  Object? arg0 = defaultArgument,
  Object? arg1 = defaultArgument,
  Object? arg2 = defaultArgument,
  Object? arg3 = defaultArgument,
  Object? arg4 = defaultArgument,
  Object? arg5 = defaultArgument,
  Object? arg6 = defaultArgument,
  Object? arg7 = defaultArgument,
  Object? arg8 = defaultArgument,
  Object? arg9 = defaultArgument,
]) {
  return KtHashSet.from([
    if (arg0 != defaultArgument) arg0 as T,
    if (arg1 != defaultArgument) arg1 as T,
    if (arg2 != defaultArgument) arg2 as T,
    if (arg3 != defaultArgument) arg3 as T,
    if (arg4 != defaultArgument) arg4 as T,
    if (arg5 != defaultArgument) arg5 as T,
    if (arg6 != defaultArgument) arg6 as T,
    if (arg7 != defaultArgument) arg7 as T,
    if (arg8 != defaultArgument) arg8 as T,
    if (arg9 != defaultArgument) arg9 as T,
  ]);
}

/// Returns a new [HashSet] based on [elements].
/// Elements of the set are iterated in unpredictable order.
KtMutableSet<T> hashSetFrom<T>([Iterable<T> elements = const []]) =>
    KtHashSet.from(elements);
