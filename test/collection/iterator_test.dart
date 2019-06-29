import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/iterator.dart";
import "package:test/test.dart";

import "../test/assert_dart.dart";

void main() {
  group("InterOpKtListIterator", () {
    test("next at pos 0 is first element", () {
      final i = InterOpKtListIterator(["a", "b"], 0);
      expect(i.next(), "a");
    });

    test("hasNext true", () {
      final i = InterOpKtListIterator(["a", "b"], 0);
      expect(i.hasNext(), isTrue);
    });

    test("nextIndex when next exists", () {
      final i = InterOpKtListIterator(["a", "b"], 0);
      expect(i.nextIndex(), 0);
    });

    test("previousIndex when next exists", () {
      final i = InterOpKtListIterator(["a", "b"], 0);
      expect(i.previousIndex(), -1);
    });

    test("hasNext false", () {
      final i = InterOpKtListIterator(["a", "b"], 2);
      expect(i.hasNext(), isFalse);
    });

    test("nextIndex returns list size when at end", () {
      final i = InterOpKtListIterator(["a", "b"], 2);
      expect(i.nextIndex(), 2);
    });

    test("previousIndex when next exists", () {
      final i = InterOpKtListIterator(["a", "b"], 2);
      expect(i.previousIndex(), 1);
    });

    test("start index has to be in range (smaller)", () {
      final e = catchException(() => InterOpKtListIterator(["a", "b"], -1));
      expect(e, const TypeMatcher<IndexOutOfBoundsException>());
    });

    test("start index has to be in range (larger)", () {
      final e = catchException(() => InterOpKtListIterator(["a", "b"], 3));
      expect(e, const TypeMatcher<IndexOutOfBoundsException>());
    });

    test("remove is not implemented", () {
      final i = InterOpKtListIterator(["a", "b"], 0);
      final e = catchException(() => i.remove());
      expect(e, const TypeMatcher<UnimplementedError>());
    });

    test("add adds item to underlying list", () {
      final dartList = ["a", "b"];
      final i = InterOpKtListIterator(dartList, 0);
      i.add("c");
      expect(dartList, equals(["c", "a", "b"]));
    });

    test("set modifies current item", () {
      final dartList = ["a", "b"];
      final i = InterOpKtListIterator(dartList, 0);
      expect(i.next(), equals("a"));
      i.set("x");
      expect(dartList, equals(["x", "b"]));
      expect(i.previous(), equals("x"));
      expect(i.next(), equals("x"));
      expect(i.next(), equals("b"));
      expect(i.previous(), equals("b"));
    });
    test("set requires next() before beeing called", () {
      final i = InterOpKtListIterator(["a", "b"], 0);
      final e = catchException<IndexOutOfBoundsException>(() => i.set("x"));
      expect(e.message, allOf(contains("-1"), contains("next()")));
    });
  });

  test("iterate backwards", () {
    final iter = listOf("a", "b", "c").listIterator(3);
    expect(iter.hasNext(), isFalse);
    expect(iter.hasPrevious(), isTrue);
    expect(iter.previousIndex(), 2);
    expect(iter.nextIndex(), 3);
    expect(iter.previous(), "c");

    expect(iter.hasNext(), isTrue);
    expect(iter.hasPrevious(), isTrue);
    expect(iter.previousIndex(), 1);
    expect(iter.nextIndex(), 2);
    expect(iter.previous(), "b");

    expect(iter.hasNext(), isTrue);
    expect(iter.hasPrevious(), isTrue);
    expect(iter.previousIndex(), 0);
    expect(iter.nextIndex(), 1);
    expect(iter.previous(), "a");

    expect(iter.hasNext(), isTrue);
    expect(iter.hasPrevious(), isFalse);
    expect(iter.previousIndex(), -1);
    expect(iter.nextIndex(), 0);
  });

  test("iterate forwards", () {
    final iter = listOf("a", "b", "c").listIterator(0);

    expect(iter.hasNext(), isTrue);
    expect(iter.hasPrevious(), isFalse);
    expect(iter.previousIndex(), -1);
    expect(iter.nextIndex(), 0);
    expect(iter.next(), "a");

    expect(iter.hasNext(), isTrue);
    expect(iter.hasPrevious(), isTrue);
    expect(iter.previousIndex(), 0);
    expect(iter.nextIndex(), 1);
    expect(iter.next(), "b");

    expect(iter.hasNext(), isTrue);
    expect(iter.hasPrevious(), isTrue);
    expect(iter.previousIndex(), 1);
    expect(iter.nextIndex(), 2);
    expect(iter.next(), "c");

    expect(iter.hasNext(), isFalse);
    expect(iter.hasPrevious(), isTrue);
    expect(iter.previousIndex(), 2);
    expect(iter.nextIndex(), 3);
  });
}
