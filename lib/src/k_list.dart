import 'package:dart_kollection/dart_kollection.dart';

/**
 * A generic ordered collection of elements. Methods in this interface support only read-only access to the list;
 * read/write access is supported through the [KMutableList] interface.
 * @param E the type of elements contained in the list. The list is covariant on its element type.
 */
abstract class KList<E> implements KCollection<E> {
  // Query Operations
  int get size;

  // Positional Access Operations
  /**
   * Returns the element at the specified index in the list.
   */
  E get(int index);

  // Search Operations
  /**
   * Returns the index of the first occurrence of the specified element in the list, or -1 if the specified
   * element is not contained in the list.
   */
  int indexOf(E element);

  /**
   * Returns the index of the last occurrence of the specified element in the list, or -1 if the specified
   * element is not contained in the list.
   */
  int lastIndexOf(E element);

  // List Iterators
  /**
   * Returns a list iterator over the elements in this list (in proper sequence), starting at the specified [index] or `0` by default.
   */
  KListIterator<E> listIterator([int index = 0]);

  // View
  /**
   * Returns a view of the portion of this list between the specified [fromIndex] (inclusive) and [toIndex] (exclusive).
   * The returned list is backed by this list, so non-structural changes in the returned list are reflected in this list, and vice-versa.
   *
   * Structural changes in the base list make the behavior of the view undefined.
   */
  KList<E> subList(int fromIndex, int toIndex);
}
