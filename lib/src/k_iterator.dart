import 'package:dart_kollection/dart_kollection.dart';

/**
 * An iterator over a collection or another entity that can be represented as a sequence of elements.
 * Allows to sequentially access the elements.
 */
abstract class KIterator<T> {
  /**
   * Returns the next element in the iteration.
   *
   * @return the next element in the iteration
   * @throws [NoSuchElementException] if the iteration has no more elements
   */
  @nullable
  T next();

  /**
   * Returns `true` if the iteration has more elements.
   * (In other words, returns `true` if [next} would
   * return an element rather than throwing an exception.)
   *
   * @return `true` if the iteration has more elements
   */
  bool hasNext();
}

/**
 * An iterator over a collection that supports indexed access.
 */
abstract class KListIterator<T> implements KIterator<T> {
  /**
   * Returns `true` if this list iterator has more elements when
   * traversing the list in the reverse direction.  (In other words,
   * returns `true` if [previous] would return an element
   * rather than throwing an exception.)
   *
   * @return `true` if the list iterator has more elements when
   *         traversing the list in the reverse direction
   */
  bool hasPrevious();

  /**
   * Returns the previous element in the list and moves the cursor
   * position backwards.  This method may be called repeatedly to
   * iterate through the list backwards, or intermixed with calls to
   * [next] to go back and forth.  (Note that alternating calls
   * to [next] and [previous] will return the same
   * element repeatedly.)
   *
   * @return the previous element in the list
   * @throws [NoSuchElementException] if the iteration has no previous
   *         element
   */
  @nullable
  T previous();

  /**
   * Returns the index of the element that would be returned by a
   * subsequent call to [next]. (Returns list size if the list
   * iterator is at the end of the list.)
   *
   * @return the index of the element that would be returned by a
   *         subsequent call to [next], or list size if the list
   *         iterator is at the end of the list
   */
  int nextIndex();

  /**
   * Returns the index of the element that would be returned by a
   * subsequent call to [previous]. (Returns -1 if the list
   * iterator is at the beginning of the list.)
   *
   * @return the index of the element that would be returned by a
   *         subsequent call to [previous], or -1 if the list
   *         iterator is at the beginning of the list
   */
  int previousIndex();
}
