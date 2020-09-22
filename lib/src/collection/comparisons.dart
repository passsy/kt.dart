/// Returns a comparator that compares [Comparable] objects in natural order.
Comparator<T> naturalOrder<T>() => _naturalOrder as Comparator<T>;

int _naturalOrder(Comparable<Object> a, Comparable<Object> b) => a.compareTo(b);

/// Returns a comparator that compares [Comparable] objects in reversed natural order.
Comparator<T> reverseOrder<T>() => _reverseOrder as Comparator<T>;

int _reverseOrder(Comparable<Object> a, Comparable<Object> b) => b.compareTo(a);

/// Returns a comparator that imposes the reverse ordering of this comparator.
Comparator<T> reverse<T>(Comparator<T> comparator) {
  int compareTo(T a, T b) => comparator(b, a);
  return compareTo;
}

/// Creates a comparator using the function to transform value to a [Comparable] instance for comparison.
Comparator<T> compareBy<T>(Comparable Function(T) selector) {
  int compareTo(T a, T b) => selector(a).compareTo(selector(b));
  return compareTo;
}

/// Creates a descending comparator using the function to transform value to a [Comparable] instance for comparison.
Comparator<T> compareByDescending<T>(Comparable Function(T) selector) {
  int compareTo(T a, T b) => selector(b).compareTo(selector(a));
  return compareTo;
}

extension KtComparatorExtensions<T> on Comparator<T> {
  Comparator<T> thenBy(Comparable Function(T) selector) {
    final thenComparator = compareBy(selector);

    int compareTo(T a, T b) {
      final res = this(a, b);
      return res != 0 ? res : thenComparator(a, b);
    }

    return compareTo;
  }

  Comparator<T> thenByDescending(Comparable Function(T) selector) {
    final thenComparator = compareByDescending(selector);

    int compareTo(T a, T b) {
      final res = this(a, b);
      return res != 0 ? res : thenComparator(a, b);
    }

    return compareTo;
  }
}
