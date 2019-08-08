import 'package:kt_dart/collection.dart';
import 'package:kt_dart/range.dart';
import 'package:test/test.dart';

void main() {
  group("last()", () {
    test("empty means first == endInclusive", () {
      expect(IntRange(0, 0).last(), 0);
      expect(IntRange(2, 2).last(), 2);
      expect(IntRange(-4, -4).last(), -4);
    });
    test("last returns the endInclusive value", () {
      expect(IntRange(0, 10).last(), 10);
    });
    test("step 2 returns the last value dividable by 2", () {
      expect(IntRange(0, 9, step: 2).last(), 8);
    });

    test("last minds the predicate", () {
      final range = IntRange(0, 9, step: 3);
      bool isEven(it) => it % 2 == 0;
      expect(range.last(), 9);
      expect(range.last(isEven), 6);
    });
  });

  group("first()", () {
    test("empty means first == endInclusive", () {
      expect(IntRange(0, 0).first(), 0);
      expect(IntRange(2, 2).first(), 2);
      expect(IntRange(-4, -4).first(), -4);
    });
    test("first returns the endInclusive value", () {
      expect(IntRange(2, 10).first(), 2);
    });
    test("step 2 returns the first value", () {
      // step 2 doesn't mean first needs to be dividable by 2.
      // It starts stepping at 2
      expect(IntRange(1, 9, step: 2).first(), 1);
    });

    test("first minds the predicate", () {
      final range = IntRange(1, 10, step: 3);
      bool isEven(it) => it % 2 == 0;
      expect(range.first(), 1);
      expect(range.first(isEven), 4);
    });
  });

  group("step", () {
    test("range 0..8", () {
      final range = IntRange(0, 8);
      expect(range.stepSize, 1);
      expect(range.toList(), listOf(0, 1, 2, 3, 4, 5, 6, 7, 8));
    });

    test("8..0 step 1 has zero values", () {
      final range = IntRange(8, 0);
      expect(range.stepSize, 1);
      expect(range.toList(), emptyList());
    });

    test("can be negative", () {
      final range = IntRange(10, 0, step: -3);
      expect(range.stepSize, -3);
      expect(range.toList(), listOf(10, 7, 4, 1));
    });

    test("can be positive", () {
      final range = IntRange(0, 10, step: 4);
      expect(range.stepSize, 4);
      expect(range.toList(), listOf(0, 4, 8));
    });
  });
}
