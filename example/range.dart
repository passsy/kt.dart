import "package:kt_dart/range.dart";
import "package:kt_dart/src/ranges/comparable_range.dart";

void main() {
  final test = IntRange(0, 120, step: 20);
  print(test);
  test.forEach((i) {
    print(i);
  });
  print(test.contains(11));
  print(test.contains(10));
  print(test.min());

  print(IntRange(0, 10));
  for (final i in IntRange(0, 10).iter) {
    print(i);
  }

  print(IntRange(0, 15, step: 2));
  for (final i in IntRange(0, 15, step: 2).iter) {
    print(i);
  }

  // custom ranges
  final containsValue = const ComparableRange<num>(1, 10).contains(2);
  print("custom contains value $containsValue");
  final containsSubrange = const ComparableRange<num>(1, 10)
      .contains(const ComparableRange<num>(2, 3));
  print("custom contains subrange $containsSubrange");
  final doesNotContainRange = const ComparableRange<num>(1, 5)
      .contains(const ComparableRange<num>(4, 6));
  print("does not contain overlapping range $doesNotContainRange");
}
