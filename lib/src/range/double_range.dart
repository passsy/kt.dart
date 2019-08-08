import "package:kt_dart/src/ranges/closed_range.dart";

/// A closed range of values of type [double]
///
/// Numbers are compared with the ends of this range according to IEEE-754.
class ClosedDoubleRange extends ClosedFloatingPointRange<double> {
  const ClosedDoubleRange(this.start, this.endInclusive);

  @override
  final double start;

  @override
  final double endInclusive;

  @override
  bool lessThanOrEquals(double a, double b) => a <= b;

  @override
  bool contains(dynamic value) => value >= start && value <= endInclusive;

  @override
  bool isEmpty() => !(start <= endInclusive);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClosedDoubleRange &&
          runtimeType == other.runtimeType &&
          (isEmpty() && other.isEmpty() ||
              start == other.start && endInclusive == other.endInclusive);

  @override
  int get hashCode {
    if (isEmpty()) return -1;
    return start.hashCode ^ endInclusive.hashCode;
  }

  @override
  String toString() => "$start..$endInclusive";
}

ClosedFloatingPointRange<double> doubleRange(double first, double last,
        {double step = 1}) =>
    ClosedDoubleRange(first, last);
