import 'package:kotlin_dart/collection.dart';
import 'package:kotlin_dart/src/collection/impl/iterator.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group('InterOpKtListIterator', () {
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
      expect(i.nextIndex(), 1);
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
      expect(e, TypeMatcher<IndexOutOfBoundsException>());
    });

    test("start index has to be in range (larger)", () {
      final e = catchException(() => InterOpKtListIterator(["a", "b"], 3));
      expect(e, TypeMatcher<IndexOutOfBoundsException>());
    });

    test("remove is not implemented", () {
      final i = InterOpKtListIterator(["a", "b"], 0);
      final e = catchException(() => i.remove());
      expect(e, TypeMatcher<UnimplementedError>());
    });

    test("add adds item to underlying list", () {
      var dartList = ["a", "b"];
      final i = InterOpKtListIterator(dartList, 0);
      i.add("c");
      expect(dartList, equals(["c", "a", "b"]));
    });

    test("set modifies current item", () {
      var dartList = ["a", "b"];
      final i = InterOpKtListIterator(dartList, 0);
      expect(i.next(), equals("a"));
      i.set("x");
      expect(dartList, equals(["x", "b"]));
      expect(i.previous(), equals("x"));
      expect(i.next(), equals("x"));
      expect(i.next(), equals("b"));
      expect(i.previous(), equals("b"));
    });
  });
}
