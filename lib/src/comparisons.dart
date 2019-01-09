/**
 * Returns a comparator that compares [Comparable] objects in natural order.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
Comparator<T> naturalOrder<T>() => _naturalOrder as Comparator<T>;

int _naturalOrder(Comparable<Object> a, Comparable<Object> b) => a.compareTo(b);

/**
 * Returns a comparator that compares [Comparable] objects in reversed natural order.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
Comparator<T> reverseOrder<T>() => _reverseOrder as Comparator<T>;

int _reverseOrder(Comparable<Object> a, Comparable<Object> b) => b.compareTo(a);

/**
 * Returns a comparator that imposes the reverse ordering of this comparator.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
Comparator<T> reverse<T>(Comparator<T> comparator) {
  int compareTo(T a, T b) => comparator(b, a);
  return compareTo;
}

/**
 * Creates a comparator using the function to transform value to a [Comparable] instance for comparison.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
Comparator<T> compareBy<T>(Comparable Function(T) selector) {
  int compareTo(T a, T b) => selector(a).compareTo(selector(b));
  return compareTo;
}

/**
 * Creates a descending comparator using the function to transform value to a [Comparable] instance for comparison.
 */
@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
Comparator<T> compareByDescending<T>(Comparable Function(T) selector) {
  int compareTo(T a, T b) => selector(b).compareTo(selector(a));
  return compareTo;
}
