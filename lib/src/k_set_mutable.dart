import 'dart:collection';

import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/set_mutable.dart';
import 'package:dart_kollection/src/util/arguments.dart';

/**
 * A generic unordered collection of elements that does not support duplicate elements, and supports
 * adding and removing elements.
 * @param [T] the type of elements contained in the set. The mutable set is invariant on its element type.
 */
abstract class KMutableSet<T> implements KSet<T>, KMutableCollection<T> {
  factory KMutableSet.from([Iterable<T> elements = const []]) {
    return DartMutableSet.noCopy(LinkedHashSet<T>.of(elements));
  }

  factory KMutableSet.of(
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
    final args =
        argsToList(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    return KMutableSet.from(args);
  }

  // Query Operations
  @override
  KMutableIterator<T> iterator();

  // Modification Operations
  @override
  bool add(T element);

  @override
  bool remove(T element);

  // Bulk Modification Operations
  @override
  bool addAll(KIterable<T> elements);

  @override
  bool removeAll(KIterable<T> elements);

  @override
  bool retainAll(KIterable<T> elements);

  @override
  void clear();
}
