import 'package:dart_kollection/dart_kollection.dart';

/**
 * An iterator over a mutable collection. Provides the ability to remove elements while iterating.
 * @see MutableCollection.iterator
 */
abstract class KMutableIterator<T> implements KIterator<T> {
  /**
   * Removes from the underlying collection the last element returned by this iterator.
   */
  void remove();
}

/**
 * An iterator over a mutable collection that supports indexed access. Provides the ability
 * to add, modify and remove elements while iterating.
 */
abstract class KMutableListIterator<T>
    implements KListIterator<T>, KMutableIterator<T> {
  /**
   * Replaces the last element returned by [next] or [previous] with the specified element [element].
   */
  void set(T element);

  /**
   * Adds the specified element [element] into the underlying collection immediately before the element that would be
   * returned by [next], if any, and after the element that would be returned by [previous], if any.
   * (If the collection contains no elements, the new element becomes the sole element in the collection.)
   * The new element is inserted before the implicit cursor: a subsequent call to [next] would be unaffected,
   * and a subsequent call to [previous] would return the new element. (This call increases by one the value \
   * that would be returned by a call to [nextIndex] or [previousIndex].)
   */
  void add(T element);
}
