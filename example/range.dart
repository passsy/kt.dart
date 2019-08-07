import "package:kt_dart/range.dart";
import "package:kt_dart/src/ranges/comparable_range.dart";

void main() {
  final test = range(0, 120, step: 20);
  print(test);
  test.forEach((i) {
    print(i);
  });
  print(test.contains(11));
  print(test.contains(10));
  print(test.min());

  print(range(0, 10));
  for (final i in range(0, 10).iter) {
    print(i);
  }

  print(range(0, 15, step: 2));
  for (final i in range(0, 15, step: 2).iter) {
    print(i);
  }

  // custom ranges
  final containsValue = rangeOf<num>(1, 10).contains(2);
  print("custom contains value $containsValue");
  final containsSubrange = rangeOf<num>(1, 10).contains(rangeOf<num>(2, 3));
  print("custom contains subrange $containsSubrange");
  final doesNotContainRange = rangeOf<num>(1, 5).contains(rangeOf<num>(4, 6));
  print("does not contain overlapping range $doesNotContainRange");
}
