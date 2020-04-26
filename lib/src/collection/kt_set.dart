import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/set.dart";
import "package:kt_dart/src/collection/impl/set_empty.dart";
import "package:kt_dart/src/util/arguments.dart";

/// A generic unordered collection of elements that does not support duplicate elements.
/// Methods in this interface support only read-only access to the set;
/// read/write access is supported through the [KtMutableSet] interface.
/// @param E the type of elements contained in the set. The set is covariant on its element type.
abstract class KtSet<T> implements KtCollection<T> {
  /// Returns an empty read-only set.
  const factory KtSet.empty() = EmptySet<T>;

  /// Returns a new read-only set based on [elements].
  factory KtSet.from([@nonNull Iterable<T> elements = const []]) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    if (elements.isEmpty) return EmptySet<T>();
    return DartSet(elements);
  }

  /// Returns a new read-only set of given elements.
  ///
  /// `null` is a valid argument
  factory KtSet.of([
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
  ]) = KtSet<T>._of;

  factory KtSet._of(
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

  /// Deprecated, use [asSet] or [iter] for loops
  @Deprecated("use asSet() or iter instead")
  Set<T> get set;

  // Query Operations
  @override
  int get size;

  /// returns a read-only dart:core [Set]
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  ///
  /// - Use [iter] to iterate over the elements of this [KtSet] using a for-loop
  /// - Use [toSet] to copy the set
  Set<T> asSet();

  @override
  bool isEmpty();

  @override
  bool contains(T element);

  @override
  bool containsAll(KtCollection<T> elements);

  // Bulk Operations
  @override
  KtIterator<T> iterator();
}

extension KtSetExtension<T> on KtSet<T> {
  /// Returns a read-only dart:core [Set]
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  Set<T> get dart => asSet();

  /// Returns a set containing all elements of the original collection except
  /// the elements contained in the given [elements] collection.
  KtSet<T> minus(KtIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    final result = toMutableSet();
    result.removeAll(elements);
    return result;
  }

  /// Returns a set containing all elements of the original collection except
  /// the elements contained in the given [elements] collection.
  KtSet<T> operator -(KtIterable<T> elements) => minus(elements);

  /// Returns a set containing all elements of the original collection without
  /// the first occurrence of the given [element].
  KtSet<T> minusElement(T element) {
    final result = KtMutableSet<T>.of();
    var removed = false;
    filterTo(result, (it) {
      if (!removed && it == element) {
        removed = true;
        return false;
      } else {
        return true;
      }
    });
    return result;
  }

  /// Returns a set containing all elements of the original collection and then
  /// all elements of the given [elements] collection.
  KtSet<T> plus(KtIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    final result = KtMutableSet<T>.of();
    result.addAll(asIterable());
    result.addAll(elements);
    return result;
  }

  /// Returns a set containing all elements of the original collection and then
  /// all elements of the given [elements] collection.
  KtSet<T> operator +(KtIterable<T> elements) => plus(elements);

  /// Returns a set containing all elements of the original collection and then
  /// the given [element].
  KtSet<T> plusElement(T element) {
    final result = KtMutableSet<T>.of();
    result.addAll(asIterable());
    result.add(element);
    return result;
  }
}

extension NullableKtSetExtensions<T> on KtSet<T> /*?*/ {
  /// Returns this [KtSet] if it's not `null` and the empty set otherwise.
  KtSet<T> orEmpty() => this ?? KtSet<T>.empty();
}
