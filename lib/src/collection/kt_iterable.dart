import "package:kt_dart/collection.dart";

/// Classes that inherit from this interface can be represented as a sequence of elements that can
/// be iterated over.
/// @param T the type of element being iterated over. The iterator is covariant on its element type.
abstract class KtIterable<T> {
  /// Access to a [Iterable] to be used in for-loops
  Iterable<T> get iter;

  /// Returns an iterator over the elements of this object.
  KtIterator<T> iterator();
}
