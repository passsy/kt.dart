import "package:kt_dart/src/util/arguments.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("null throws", () {
    test("arg8 can't be null", () {
      final e = catchException<ArgumentError>(
          () => argsToList(0, 1, 2, 3, 4, 5, 6, 7, null, 9));
      expect(e.message, allOf(contains("null"), contains("position 8")));
    });

    test("arg7 can't be null", () {
      final e = catchException<ArgumentError>(
          () => argsToList(0, 1, 2, 3, 4, 5, 6, null, 8, 9));
      expect(e.message, allOf(contains("null"), contains("position 7")));
    });

    test("arg6 can't be null", () {
      final e = catchException<ArgumentError>(
          () => argsToList(0, 1, 2, 3, 4, 5, null, 7, 8, 9));
      expect(e.message, allOf(contains("null"), contains("position 6")));
    });
    test("arg5 can't be null", () {
      final e = catchException<ArgumentError>(
          () => argsToList(0, 1, 2, 3, 4, null, 6, 7, 8, 9));
      expect(e.message, allOf(contains("null"), contains("position 5")));
    });

    test("arg4 can't be null", () {
      final e = catchException<ArgumentError>(
          () => argsToList(0, 1, 2, 3, null, 5, 6, 7, 8, 9));
      expect(e.message, allOf(contains("null"), contains("position 4")));
    });

    test("arg3 can't be null", () {
      final e = catchException<ArgumentError>(
          () => argsToList(0, 1, 2, null, 4, 5, 6, 7, 8, 9));
      expect(e.message, allOf(contains("null"), contains("position 3")));
    });

    test("arg2 can't be null", () {
      final e = catchException<ArgumentError>(
          () => argsToList(0, 1, null, 3, 4, 5, 6, 7, 8, 9));
      expect(e.message, allOf(contains("null"), contains("position 2")));
    });

    test("arg1 can't be null", () {
      final e = catchException<ArgumentError>(
          () => argsToList(0, null, 2, 3, 4, 5, 6, 7, 8, 9));
      expect(e.message, allOf(contains("null"), contains("position 1")));
    });

    test("arg0 can't be null", () {
      final e = catchException<ArgumentError>(
          () => argsToList(null, 1, 2, 3, 4, 5, 6, 7, 8, 9));
      expect(e.message, allOf(contains("null"), contains("position 0")));
    });
  });

  test("arg0 == null results in empty list", () {
    final list = argsToList(null);
    expect(list.length, 0);
  });

  group("arg list with length n", () {
    test("list with length 0", () {
      expect(argsToList().length, 0);
    });
    test("list with length 1", () {
      expect(argsToList(0).length, 1);
    });
    test("list with length 2", () {
      expect(argsToList(0, 1).length, 2);
    });
    test("list with length 3", () {
      expect(argsToList(0, 1, 2).length, 3);
    });
    test("list with length 4", () {
      expect(argsToList(0, 1, 2, 3).length, 4);
    });
    test("list with length 5", () {
      expect(argsToList(0, 1, 2, 3, 4).length, 5);
    });
    test("list with length 6", () {
      expect(argsToList(0, 1, 2, 3, 4, 5).length, 6);
    });
    test("list with length 7", () {
      expect(argsToList(0, 1, 2, 3, 4, 5, 6).length, 7);
    });
    test("list with length 8", () {
      expect(argsToList(0, 1, 2, 3, 4, 5, 6, 7).length, 8);
    });
    test("list with length 9", () {
      expect(argsToList(0, 1, 2, 3, 4, 5, 6, 7, 8).length, 9);
    });
    test("list with length 10", () {
      expect(argsToList(0, 1, 2, 3, 4, 5, 6, 7, 8, 9).length, 10);
    });
  });
}
