import 'package:kt_dart/collection.dart';

abstract class KtMutableListExtensionsMixin<T>
    implements KtMutableListExtension<T>, KtMutableList<T> {
  @override
  void fill(T value) {
    for (var i = 0; i < size; i++) {
      set(i, value);
    }
  }

  @override
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

  @override
  void sortBy<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    if (size > 1) {
      sortWith(compareBy(selector));
    }
  }

  @override
  void sortByDescending<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    if (size > 1) {
      sortWith(compareByDescending(selector));
    }
  }

  @override
  void sortWith(Comparator<T> comparator) {
    assert(() {
      if (comparator == null) throw ArgumentError("comparator can't be null");
      return true;
    }());
    // delegate to darts list implementation for sorting which is highly optimized
    asList().sort(comparator);
  }

  @override
  void swap(int indexA, int indexB) {
    final firstOld = get(indexA);
    final secondOld = set(indexB, firstOld);
    set(indexA, secondOld);
  }
}
