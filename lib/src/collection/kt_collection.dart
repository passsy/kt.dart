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
  R sumOf<R extends num>(R Function(T) selector) {
    var sum = R == double ? 0.0 : 0;
    for (final element in iter) {
      sum += selector(element);
    }
    return sum as R;
  }

  /// Returns a list containing the results of applying the given [operation]
  /// function to each element in the original collection and the previous
  /// accumulator value.
  KtCollection<R> runningFold<R>(R initial, R Function(R, T) operation) {
    var accumulator = initial;
    return KtMutableList<R>.from(iter
        .map((element) => accumulator = operation(accumulator, element))
        .toList())
      ..addAt(0, initial);
  }

  /// Returns a [KtMutableList] filled with all elements of this collection.
  KtMutableList<T> toMutableList() => KtMutableList<T>.from(iter);
}

extension NullableKtCollectionExtensions<T> on KtCollection<T>? {
  /// Returns this [KtCollection] if it's not `null` and the empty list otherwise.
  KtCollection<T> orEmpty() => this ?? KtList<T>.empty();
}
