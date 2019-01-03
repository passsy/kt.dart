import 'dart:math' as math show Random;

import 'package:dart_kollection/dart_kollection.dart';

/**
 * A generic collection of elements. Methods in this interface support only read-only access to the collection;
 * read/write access is supported through the [KMutableCollection] interface.
 * @param E the type of elements contained in the collection. The collection is covariant on its element type.
 */
abstract class KCollection<T> implements KIterable<T>, KCollectionExtension<T> {
  // Query Operations
  /**
   * Returns the size of the collection.
   */
  int get size;

  /**
   * Returns `true` if the collection is empty (contains no elements), `false` otherwise.
   */
  bool isEmpty();

  /**
   * Checks if the specified element is contained in this collection.
   */
  @override
  bool contains(T element);

  @override
  KIterator<T> iterator();

  // Bulk Operations
  /**
   * Checks if all elements in the specified collection are contained in this collection.
   */
  bool containsAll(KCollection<T> elements);

  @override
  KList<T> drop(int n);
}

abstract class KCollectionExtension<T> {
  /**
   * Returns `true` if the collection is not empty.
   */
  bool isNotEmpty();

  /**
   * Returns a random element from this collection.
   *
   * @throws NoSuchElementException if this collection is empty.
   */
  T random([math.Random random]);

  /**
   * Returns a [KMutableList] filled with all elements of this collection.
   */
  KMutableList<T> toMutableList();
}
