import 'package:test/test.dart';
import 'package:kt_dart/kt.dart';

import '../test/assert_dart.dart';

void main() {
  group("TODO", () {
    test("TODO throws with default message", () {
      final e = catchException<NotImplementedException>(() => TODO());
      expect(e.message, "An operation is not implemented.");
    });
    test("TODO throws with custom message", () {
      final e =
          catchException<NotImplementedException>(() => TODO("add something"));
      expect(e.message, "add something");
    });
    test("toString()", () {
      final e =
          catchException<NotImplementedException>(() => TODO("add something"));
      expect(e.toString(), "Exception: add something");
    });
    test("alwaysThrows", () {
      try {
        TODO("The line below should be marked as dead code");
        // ignore: dead_code
        fail("did not throw");
      } on NotImplementedException {
        // expected
      }
    });
  });

  group("let", () {
    test("on non-null", () {
      const int charDec = 97;
      final char = charDec.let((it) => String.fromCharCode(it));
      expect(char, "a");
    });
    test("on null", () {
      const int? charDec = null;
      final char = charDec?.let((it) => String.fromCharCode(it));
      expect(char, isNull);
    });
  });

  group("also", () {
    test("on non-null", () {
      final list = <String>["a", "b"].also((it) {
        it.add("side-effect");
      });
      expect(list, ["a", "b", "side-effect"]);
    });
    test("on null", () {
      const List<String>? list = null;
      int called = 0;
      final listRef = list?.also((it) {
        called++;
        it.add("side-effect");
      });
      expect(listRef, null);
      expect(called, 0);
    });
  });

  group("takeIf", () {
    test("take it", () {
      final item = ["a", "b"].takeIf((it) => it.isEmpty);
      expect(item, isNull);
    });
    test("don't take it", () {
      final item = ["a", "b"].takeIf((it) => it.isNotEmpty);
      expect(item, ["a", "b"]);
    });
  });

  group("takeUnless", () {
    test("take it", () {
      final item = ["a", "b"].takeUnless((it) => it.isNotEmpty);
      expect(item, isNull);
    });
    test("don't take it", () {
      final item = ["a", "b"].takeUnless((it) => it.isEmpty);
      expect(item, ["a", "b"]);
    });
  });

  group("repeat", () {
    test("repeats 5 times", () {
      int i = 0;
      repeat(5, (_) {
        i++;
      });
      expect(i, 5);
    });
    test("repeat 0 times", () {
      int i = 0;
      repeat(0, (_) {
        i++;
      });
      expect(i, 0);
    });
    test("doesn't repeat with negative times", () {
      int i = 0;
      repeat(-1, (_) {
        i++;
      });
      expect(i, 0);
    });
    test("calls closure with index", () {
      final List<int> list = [];
      repeat(3, (i) {
        list.add(i);
      });
      expect(list, [0, 1, 2]);
    });
  });
}
