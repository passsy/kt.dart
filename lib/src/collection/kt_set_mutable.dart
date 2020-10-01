import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/impl/set_mutable.dart';
import 'package:kt_dart/src/util/arguments.dart';

/// A generic unordered collection of elements that does not support duplicate elements, and supports
/// adding and removing elements.
/// @param [T] the type of elements contained in the set. The mutable set is invariant on its element type.
abstract class KtMutableSet<T> implements KtSet<T>, KtMutableCollection<T> {
  factory KtMutableSet.empty() => KtMutableSet.from();

  factory KtMutableSet.from([@nonNull Iterable<T> elements = const []]) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    return DartMutableSet(elements);
  }

  factory KtMutableSet.of([
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
  ]) = KtMutableSet<T>._of;

  factory KtMutableSet._of(
      [Object arg0 = defaultArgument,
      Object arg1 = defaultArgument,
      Object arg2 = defaultArgument,
      Object arg3 = defaultArgument,
      Object arg4 = defaultArgument,
      Object arg5 = defaultArgument,
      Object arg6 = defaultArgument,
      Object arg7 = defaultArgument,
      Object arg8 = defaultArgument,
      Object arg9 = defaultArgument]) {
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

  /// Creates a [Set] instance that wraps the original [KtSet]. It acts as a view.
  ///
  /// Mutations on the returned [Set] are reflected on the original [KtSet]
  /// and vice versa.
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  ///
  /// - Use [iter] to iterate over the elements of this [KtSet] using a for-loop
  /// - Use [toSet] to copy the set
  @override
  Set<T> asSet();

  // Query Operations
  @override
  KtMutableIterator<T> iterator();

  // Modification Operations
  @override
  bool add(T element);

  @override
  bool remove(T element);

  // Bulk Modification Operations
  @override
  bool addAll(KtIterable<T> elements);

  @override
  bool removeAll(KtIterable<T> elements);

  @override
  bool retainAll(KtIterable<T> elements);

  @override
  void clear();
}

extension KtMutableSetExtension<T> on KtMutableSet<T> {
  /// Creates a [Set] instance that wraps the original [KtSet]. It acts as a view.
  ///
  /// Mutations on the returned [Set] are reflected on the original [KtSet]
  /// and vice versa.
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  Set<T> get dart => asSet();
}
