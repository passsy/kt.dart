import "dart:math";

import "package:kt_dart/collection.dart";


extension KtMutableListExtensions<T> on KtMutableList<T> {
  void fill(T value) {
    for (var i = 0; i < size; i++) {
      set(i, value);
    }
  }

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

  void sortBy<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    if (size > 1) {
      sortWith(compareBy(selector));
    }
  }

  void sortByDescending<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    if (size > 1) {
      sortWith(compareByDescending(selector));
    }
  }

  void sortWith(Comparator<T> comparator) {
    assert(() {
      if (comparator == null) throw ArgumentError("comparator can't be null");
      return true;
    }());
    // delegate to darts list implementation for sorting which is highly optimized
    asList().sort(comparator);
  }

  void swap(int indexA, int indexB) {
    final firstOld = get(indexA);
    final secondOld = set(indexB, firstOld);
    set(indexA, secondOld);
  }

  void shuffle([Random random]) {
    // delegate to darts list implementation for shuffling
    asList().shuffle(random);
  }
}
