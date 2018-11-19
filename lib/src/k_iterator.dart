/**
 * An iterator over a collection or another entity that can be represented as a sequence of elements.
 * Allows to sequentially access the elements.
 */
abstract class KIterator<T> {
  /**
   * Returns the next element in the iteration.
   */
  T next();

  /**
   * Returns `true` if the iteration has more elements.
   */
  bool hasNext();
}

/**
 * An iterator over a collection that supports indexed access.
 * @see List.listIterator
 */
abstract class KListIterator<T> implements KIterator<T> {
  const KListIterator();

  /**
   * Returns `true` if there are elements in the iteration before the current element.
   */
  bool hasPrevious();

  /**
   * Returns the previous element in the iteration and moves the cursor position backwards.
   */
  T previous();

  /**
   * Returns the index of the element that would be returned by a subsequent call to [next].
   */
  int nextIndex();

  /**
   * Returns the index of the element that would be returned by a subsequent call to [previous].
   */
  int previousIndex();
}
