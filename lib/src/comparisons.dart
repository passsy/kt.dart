/**
 * Returns a comparator that compares [Comparable] objects in natural order.
 */
Comparator<T> naturalOrder<T>() => _naturalOrder as Comparator<T>;

int _naturalOrder(Comparable<Object> a, Comparable<Object> b) => a.compareTo(b);

/**
 * Returns a comparator that compares [Comparable] objects in reversed natural order.
 */
Comparator<T> reverseOrder<T>() => _reverseOrder as Comparator<T>;

int _reverseOrder(Comparable<Object> a, Comparable<Object> b) => b.compareTo(a);

/**
 * Returns a comparator that imposes the reverse ordering of this comparator.
 */
Comparator<T> reverse<T>(Comparator<T> comparator) {
  int compareTo(T a, T b) => comparator(b, a);
  return compareTo;
}

//class _ReversedComparator<T> {
//  _ReversedComparator(this.comparator);
//
//  Comparator<T> comparator;
//
//  int compareTo(T a, T b) => comparator(b, a);
//}

Comparator<T> compareBy<T>(Comparable Function(T) selector) {
  int compareTo(T a, T b) => selector(a).compareTo(selector(b));

  return compareTo;
}

Comparator<T> compareByDescending<T>(Comparable Function(T) selector) {
  int compareTo(T a, T b) => selector(b).compareTo(selector(a));

  return compareTo;
}

//class _CompareBy<T> {
//  Comparable Function(T) selector;
//
//  _CompareBy(this.selector);
//
//  int compareTo(T a, T b) => selector(a).compareTo(selector(b));
//}
