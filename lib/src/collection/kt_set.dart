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
  factory KtSet.empty() = EmptySet<T>;

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
  /// Elements aren't allowed to be `null`. If your set requires a `null` value use [KtSet.from]
  factory KtSet.of(
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
    return KtSet.from(args);
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
}

extension NullableKtSetExtensions<T> on KtSet<T> /*?*/ {
  /// Returns this [KtSet] if it's not `null` and the empty set otherwise.
  KtSet<T> orEmpty() => this ?? KtSet<T>.empty();
}
