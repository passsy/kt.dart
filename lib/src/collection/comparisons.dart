/// Returns a comparator that compares [Comparable] objects in natural order.
Comparator<T> naturalOrder<T>() => _naturalOrder as Comparator<T>;

int _naturalOrder(Comparable<Object> a, Comparable<Object> b) => a.compareTo(b);

/// Returns a comparator that compares [Comparable] objects in reversed natural order.
Comparator<T> reverseOrder<T>() => _reverseOrder as Comparator<T>;

int _reverseOrder(Comparable<Object> a, Comparable<Object> b) => b.compareTo(a);

/// Returns a comparator that imposes the reverse ordering of this comparator.
///
/// Deprecated in favour of the [ComparatorExt].reverse() extension which is
/// easier to find and doesn't create a top-level function
@Deprecated("Use the Comparator.reverse() extension")
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

extension ComparatorExt<T> on Comparator<T> {
  /// Returns a comparator that imposes the reverse ordering of this comparator.
  Comparator<T> reverse() {
    int compareTo(T a, T b) => this.call(b, a);
    return compareTo;
  }

  /// Creates a comparator comparing values after the primary comparator
  /// defined them equal. It uses the [selector] function to transform values
  /// to a [Comparable] instance for comparison.
  Comparator<T> thenBy(Comparable Function(T) selector) {
    int _compare(T a, T b) {
      final previousCompare = this.call(a, b);
      if (previousCompare != 0) {
        return previousCompare;
      }
      // Equals using the first Comparator, continue with next Comparator
      return selector(a).compareTo(selector(b));
    }

    return _compare;
  }

  /// Creates a descending comparator comparing values after the primary
  /// comparator  defined them equal. It uses the [selector] function to
  /// transform values to a [Comparable] instance for comparison.
  Comparator<T> thenByDescending(Comparable Function(T) selector) {
    int _compare(T a, T b) {
      final previousCompare = this.call(a, b);
      if (previousCompare != 0) {
        return previousCompare;
      }
      // Equals using the first Comparator, continue with next Comparator
      return selector(b).compareTo(selector(a));
    }

    return _compare;
  }

  /// Creates a comparator comparing values after the primary comparator
  /// defined them equal.
  Comparator<T> thenWith(Comparator comparator) {
    int _compare(T a, T b) {
      final previousCompare = this.call(a, b);
      if (previousCompare != 0) {
        return previousCompare;
      }
      // Equals using the first Comparator, continue with next Comparator
      return comparator.call(a, b);
    }

    return _compare;
  }
}
