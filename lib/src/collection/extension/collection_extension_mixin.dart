import "dart:math" as math show Random;

import "package:kt_dart/collection.dart";

extension KtCollectionExtensions<T> on KtCollection<T> {
  /// Returns `true` if the collection is not empty.
  bool isNotEmpty() => size > 0;

  /// Returns a random element from this collection.
  ///
  /// @throws NoSuchElementException if this collection is empty.
  T random([math.Random random]) {
    final r = random ?? math.Random();
    return elementAt(r.nextInt(size));
  }

  /// Returns a [KtMutableList] filled with all elements of this collection.
  KtMutableList<T> toMutableList() => KtMutableList<T>.from(iter);
}
