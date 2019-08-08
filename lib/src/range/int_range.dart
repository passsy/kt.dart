import "package:kt_dart/range.dart";
import "package:kt_dart/src/ranges/int_progression.dart";

class IntRange extends IntProgression implements ClosedRange<int> {
  IntRange(this.start, this.endInclusive, {int step = 1})
      : super(start, endInclusive, step);

  @override
  final int endInclusive;

  @override
  final int start;

  @override
  bool contains(covariant dynamic element) => indexOf(element) >= 0;
}

//IntRange range(int first, int last, {int step = 1}) =>
//    IntRange(first, last, step: step);
