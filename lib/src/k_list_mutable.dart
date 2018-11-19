import 'package:dart_kollection/dart_kollection.dart';

/**
 * A generic ordered collection of elements that supports adding and removing elements.
 * @param E the type of elements contained in the list. The mutable list is invariant on its element type.
 */
abstract class KMutableList<E> implements KList<E>, KMutableCollection<E> {
  /**
   * Inserts all of the elements in the specified collection [elements] into this list at the specified [index].
   *
   * @return `true` if the list was changed as the result of the operation.
   */
  bool addAllAt(int index, KCollection<E> elements);

// Positional Access Operations
  /**
   * Replaces the element at the specified position in this list with the specified element.
   *
   * @return the element previously at the specified position.
   */
  E set(int index, E element);

  /**
   * Inserts an element into the list at the specified [index].
   */
  void addAt(int index, E element);

  /**
   * Removes an element at the specified [index] from the list.
   *
   * @return the element that has been removed.
   */
  E removeAt(int index);
}
