import "dart:math" as math show Random;

import "package:kt_dart/collection.dart";

/// A generic collection of elements. Methods in this interface support only read-only access to the collection;
/// read/write access is supported through the [KtMutableCollection] interface.
/// @param E the type of elements contained in the collection. The collection is covariant on its element type.
abstract class KtCollection<T> implements KtIterable<T> {
  // Query Operations
  /// Returns the size of the collection.
  int get size;

  /// Returns `true` if the collection is empty (contains no elements), `false` otherwise.
  bool isEmpty();

  /// Checks if the specified element is contained in this collection.
  bool contains(T element);

  @override
  KtIterator<T> iterator();

  // Bulk Operations
  /// Checks if all elements in the specified collection are contained in this collection.
  bool containsAll(KtCollection<T> elements);
}

extension KtCollectionExtensions<T> on KtCollection<T> {
  /// Returns `true` if the collection is not empty.
  bool isNotEmpty() => size > 0;

  /// Returns a random element from this collection.
  ///
  /// @throws NoSuchElementException if this collection is empty.
  T random([math.Random? random]) {
    final r = random ?? math.Random();
    return elementAt(r.nextInt(size));
  }

  /// Returns a random element from this collection.
  ///
  /// returns null if this collection is empty.
  T? randomOrNull([math.Random? random]) {
    if (!isNotEmpty()) return null;
    final r = random ?? math.Random();
    final index = r.nextInt(size);
    if (index >= size) return null;
    return elementAt(index);
  }

  /// Returns the sum of all elements in this collection.
  T sumOf(num Function(T) selector) {
    num sum = 0;
    for (final element in iter) {
      sum += selector(element);
    }
    return sum as T;
  }

  /// Returns a [KtMutableList] filled with all elements of this collection.
  KtMutableList<T> toMutableList() => KtMutableList<T>.from(iter);
}

extension NullableKtCollectionExtensions<T> on KtCollection<T>? {
  /// Returns this [KtCollection] if it's not `null` and the empty list otherwise.
  KtCollection<T> orEmpty() => this ?? KtList<T>.empty();
}
