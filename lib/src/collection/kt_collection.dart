import 'dart:math' as math show Random;

import 'package:kt_dart/collection.dart';

/**
 * A generic collection of elements. Methods in this interface support only read-only access to the collection;
 * read/write access is supported through the [KtMutableCollection] interface.
 * @param E the type of elements contained in the collection. The collection is covariant on its element type.
 */
abstract class KtCollection<T>
    implements KtIterable<T>, KCollectionExtension<T> {
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
  KtIterator<T> iterator();

  // Bulk Operations
  /**
   * Checks if all elements in the specified collection are contained in this collection.
   */
  bool containsAll(KtCollection<T> elements);

  @override
  KtList<T> drop(int n);
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
   * Returns a [KtMutableList] filled with all elements of this collection.
   */
  KtMutableList<T> toMutableList();
}
