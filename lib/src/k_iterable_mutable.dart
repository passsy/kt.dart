import 'package:dart_kollection/dart_kollection.dart';

/**
 * Classes that inherit from this interface can be represented as a sequence of elements that can
 * be iterated over and that supports removing elements during iteration.
 * @param T the type of element being iterated over. The mutable iterator is invariant on its element type.
 */
abstract class KMutableIterable<T>
    implements KIterable<T>, KMutableIterableExtension<T> {
  /**
   * Returns an iterator over the elements of this sequence that supports removing elements during iteration.
   */
  @override
  KMutableIterator<T> iterator();
}

abstract class KMutableIterableExtension<T> {
  /**
   * Removes all elements from this [MutableIterable] that match the given [predicate].
   *
   * @return `true` if any element was removed from the collection, `false` if the collection was not modified.
   */
  bool removeAllWhere(bool Function(T) predicate);

  /**
   * Retains only elements of this [MutableIterable] that match the given [predicate]
   *
   * @return `true` if any element was removed from the collection, `false` if the collection was not modified.
   */
  bool retainAllWhere(bool Function(T) predicate);
}
