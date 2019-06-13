import 'package:kt_dart/range.dart';

/// Represents a range of [Comparable] values.
class ComparableRange<T extends Comparable<T>> extends ClosedRange<T> {
  const ComparableRange(this.start, this.endInclusive);

  @override
  final T start;
  @override
  final T endInclusive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComparableRange &&
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

ClosedRange<T> rangeOf<T extends Comparable<T>>(T from, T to) =>
    ComparableRange(from, to);
