import 'package:dart_kollection/dart_kollection.dart';

/**
 * A generic ordered collection of elements. Methods in this interface support only read-only access to the list;
 * read/write access is supported through the [KMutableList] interface.
 * @param E the type of elements contained in the list. The list is covariant on its element type.
 */
abstract class KList<T> implements KCollection<T>, KListExtension<T> {
  // Query Operations
  @override
  int get size;

  // Positional Access Operations
  /**
   * Returns the element at the specified index in the list or throw [IndexOutOfBoundsException]
   */
  @nullable
  T get(int index);

  /**
   * Returns the element at the specified index in the list or throw [IndexOutOfBoundsException]
   */
  @nullable
  T operator [](int index) => get(index);

  // Search Operations
  /**
   * Returns the index of the first occurrence of the specified element in the list, or -1 if the specified
   * element is not contained in the list.
   */
  int indexOf(T element);

  /**
   * Returns the index of the last occurrence of the specified element in the list, or -1 if the specified
   * element is not contained in the list.
   */
  int lastIndexOf(T element);

  // List Iterators
  /**
   * Returns a list iterator over the elements in this list (in proper sequence), starting at the specified [index] or `0` by default.
   */
  KListIterator<T> listIterator([int index = 0]);

  // View
  /**
   * Returns a view of the portion of this list between the specified [fromIndex] (inclusive) and [toIndex] (exclusive).
   * The returned list is backed by this list, so non-structural changes in the returned list are reflected in this list, and vice-versa.
   *
   * Structural changes in the base list make the behavior of the view undefined.
   */
  KList<T> subList(int fromIndex, int toIndex);
}

abstract class KListExtension<T> {
  /**
   * Returns the index of the last item in the list or -1 if the list is empty.
   */
  int get lastIndex;

  /**
   * Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this list.
   *
   * returns `null` when [defaultValue] return `null`
   */
  @nullable
  T getOrElse(int index, T Function(int) defaultValue);

  /**
   * Returns an element at the given [index] or `null` if the [index] is out of bounds of this list.
   */
  @nullable
  T getOrNull(int index);

  /**
   * Returns a list containing all elements except last [n] elements.
   */
  KList<T> dropLast(int n);

  /**
   * Returns a list containing all elements except last elements that satisfy the given [predicate].
   */
  KList<T> dropLastWhile(bool Function(T) predicate);

  /**
   * Returns an element at the given [index] or throws an [IndexOutOfBoundsException] if the [index] is out of bounds of this list.
   */
  @nullable
  T elementAt(int index);

  /**
   * Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this list.
   *
   * returns `null` when [defaultValue] return `null`
   */
  @nullable
  T elementAtOrElse(int index, T defaultValue(int index));

  /**
   * Returns an element at the given [index] or `null` if the [index] is out of bounds of this collection.
   */
  @nullable
  T elementAtOrNull(int index);

  /**
   * Returns a list containing elements at specified [indices].
   */
  KList<T> slice(KIterable<int> indices);
}
