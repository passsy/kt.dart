import 'package:dart_kollection/dart_kollection.dart';

/**
 * A generic ordered collection of elements that supports adding and removing elements.
 * @param E the type of elements contained in the list. The mutable list is invariant on its element type.
 */
abstract class KMutableList<T> implements KList<T>, KMutableCollection<T>, KMutableListExtension<T> {
  /**
   * Inserts all of the elements in the specified collection [elements] into this list at the specified [index].
   *
   * @return `true` if the list was changed as the result of the operation.
   */
  bool addAllAt(int index, KCollection<T> elements);

// Positional Access Operations
  /**
   * Replaces the element at the specified position in this list with the specified element.
   *
   * @return the element previously at the specified position.
   */
  T set(int index, T element);

  /**
   * Inserts an element into the list at the specified [index].
   */
  void addAt(int index, T element);

  /**
   * Removes an element at the specified [index] from the list.
   *
   * @return the element that has been removed.
   */
  T removeAt(int index);
}

abstract class KMutableListExtension<T> {
  /**
   * Fills the list with the provided [value].
   *
   * Each element in the list gets replaced with the [value].
   */
  void fill(T value);
}
