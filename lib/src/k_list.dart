import 'package:dart_kollection/dart_kollection.dart';

/**
 * A generic ordered collection of elements. Methods in this interface support only read-only access to the list;
 * read/write access is supported through the [KMutableList] interface.
 * @param E the type of elements contained in the list. The list is covariant on its element type.
 */
abstract class KList<T> implements KCollection<T>, KListExtension<T> {
  /**
   * dart interop list for time critical operations such as sorting
   */
  List<T> get list;

  // Query Operations
  @override
  int get size;

  @override
  bool isEmpty();

  @override
  bool contains(T element);

  @override
  KIterator<T> iterator();

  // Bulk Operations
  @override
  bool containsAll(KCollection<T> elements);

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
  T operator [](int index);

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
  @nonNull
  T elementAt(int index);

  /**
   * Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this list.
   */
  @nonNull
  T elementAtOrElse(int index, T defaultValue(int index));

  /**
   * Returns an element at the given [index] or `null` if the [index] is out of bounds of this collection.
   */
  @nullable
  T elementAtOrNull(int index);

  /**
   * Accumulates value starting with [initial] value and applying [operation] from right to left to each element and current accumulator value.
   */
  R foldRight<R>(R initial, R Function(T, R acc) operation);

  /**
   * Accumulates value starting with [initial] value and applying [operation] from right to left
   * to each element with its index in the original list and current accumulator value.
   * @param [operation] function that takes the index of an element, the element itself
   * and current accumulator value, and calculates the next accumulator value.
   */
  R foldRightIndexed<R>(R initial, R Function(int index, T, R acc) operation);

  /**
   * Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this list.
   */
  @nonNull
  T getOrElse(int index, T Function(int) defaultValue);

  /**
   * Returns an element at the given [index] or `null` if the [index] is out of bounds of this list.
   */
  @nullable
  T getOrNull(int index);

  /**
   * Returns the last element matching the given [predicate].
   * @throws [NoSuchElementException] if no such element is found.
   */
  @nonNull
  T last([bool Function(T) predicate]);

  /**
   * Returns the index of the last item in the list or -1 if the list is empty.
   */
  int get lastIndex;

  /**
   * Accumulates value starting with last element and applying [operation] from right to left to each element and current accumulator value.
   */
  S reduceRight<S>(S Function(T, S acc) operation);

  /**
   * Accumulates value starting with last element and applying [operation] from right to left
   * to each element with its index in the original list and current accumulator value.
   * @param [operation] function that takes the index of an element, the element itself
   * and current accumulator value, and calculates the next accumulator value.
   */
  S reduceRightIndexed<S>(S Function(int index, T, S acc) operation);

  /**
   * Returns a list containing elements at specified [indices].
   */
  KList<T> slice(KIterable<int> indices);
}
