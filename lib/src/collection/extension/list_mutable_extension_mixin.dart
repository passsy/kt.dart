import "dart:math";

import "package:kt_dart/collection.dart";

extension KtMutableListExtensions<T> on KtMutableList<T> {
  /// Fills the list with the provided [value].
  ///
  /// Each element in the list gets replaced with the [value].
  void fill(T value) {
    for (var i = 0; i < size; i++) {
      set(i, value);
    }
  }

  /// Reverses elements in the list in-place.
  void reverse() {
    final mid = size >> 1;

    var i = 0;
    var j = size - 1;
    while (i < mid) {
      swap(i, j);
      i++;
      j--;
    }
  }

  /// Sorts elements in the list in-place according to natural sort order of the value returned by specified [selector] function.
  void sortBy<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    if (size > 1) {
      sortWith(compareBy(selector));
    }
  }

  /// Sorts elements in the list in-place descending according to natural sort order of the value returned by specified [selector] function.
  void sortByDescending<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    if (size > 1) {
      sortWith(compareByDescending(selector));
    }
  }

  /// Sorts elements in the list in-place according to the specified [comparator]
  void sortWith(Comparator<T> comparator) {
    assert(() {
      if (comparator == null) throw ArgumentError("comparator can't be null");
      return true;
    }());
    // delegate to darts list implementation for sorting which is highly optimized
    asList().sort(comparator);
  }

  /// Swaps the elements at the specified positions in the specified list.
  /// (If the specified positions are equal, invoking this method leaves
  /// the list unchanged.)
  void swap(int indexA, int indexB) {
    final firstOld = get(indexA);
    final secondOld = set(indexB, firstOld);
    set(indexA, secondOld);
  }

  /// Shuffles elements in the list.
  void shuffle([Random random]) {
    // delegate to darts list implementation for shuffling
    asList().shuffle(random);
  }
}
