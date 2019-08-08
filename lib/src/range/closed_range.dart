/// Represents a range of values (for example, numbers or characters)
/// with a fixed [start] value and a fixed [endInclusive] value.
abstract class ClosedRange<T> {
  const ClosedRange();

  /// The minimum value in the range.
  T get start;

  /// The maximum value in the range (inclusive).
  T get endInclusive;

  static int _compare(dynamic a, dynamic b) {
    if (a is Comparable) {
      return a.compareTo(b);
    } else if (b is Comparable) {
      return -b.compareTo(a);
    } else {
      throw ArgumentError("Items not Comparable\n\ta=$a\n\tb=$b");
    }
  }

  /// Checks whether the specified [value] belongs to the range.
  bool contains(dynamic value) {
    if (value is ClosedRange) {
      return _compare(value.start, start) >= 0 &&
          _compare(value.endInclusive, endInclusive) <= 0;
    }
    return _compare(value, start) >= 0 && _compare(value, endInclusive) <= 0;
  }

  /// Checks whether the range is empty.
  bool isEmpty() => _compare(start, endInclusive) > 0;
}

/// Represents a range of floating point numbers.
/// Extends [ClosedRange] interface providing custom operation [lessThanOrEquals] for comparing values of range domain type.
///
/// This interface is implemented by floating point ranges returned by [Float.rangeTo] and [Double.rangeTo] operators to
/// achieve IEEE-754 comparison order instead of total order of floating point numbers.
abstract class ClosedFloatingPointRange<T> implements ClosedRange<T> {
  const ClosedFloatingPointRange();

  @override
  bool contains(dynamic value) =>
      lessThanOrEquals(start, value) && lessThanOrEquals(value, endInclusive);

  @override
  bool isEmpty() => !lessThanOrEquals(start, endInclusive);

  /// Compares two values of range domain type and returns true if first is less than or equal to second.
  bool lessThanOrEquals(T a, T b);
}
