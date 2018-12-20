import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/iterator.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group('InterOpKListIterator', () {
    test("next at pos 0 is first element", () {
      final i = InterOpKListIterator(["a", "b"], 0);
      expect(i.next(), "a");
    });

    test("hasNext true", () {
      final i = InterOpKListIterator(["a", "b"], 0);
      expect(i.hasNext(), isTrue);
    });

    test("nextIndex when next exists", () {
      final i = InterOpKListIterator(["a", "b"], 0);
      expect(i.nextIndex(), 1);
    });

    test("previousIndex when next exists", () {
      final i = InterOpKListIterator(["a", "b"], 0);
      expect(i.previousIndex(), -1);
    });

    test("hasNext false", () {
      final i = InterOpKListIterator(["a", "b"], 2);
      expect(i.hasNext(), isFalse);
    });

    test("nextIndex returns list size when at end", () {
      final i = InterOpKListIterator(["a", "b"], 2);
      expect(i.nextIndex(), 2);
    });

    test("previousIndex when next exists", () {
      final i = InterOpKListIterator(["a", "b"], 2);
      expect(i.previousIndex(), 1);
    });

    test("start index has to be in range (smaller)", () {
      final e = catchException(() => InterOpKListIterator(["a", "b"], -1));
      expect(e, TypeMatcher<IndexOutOfBoundsException>());
    });

    test("start index has to be in range (larger)", () {
      final e = catchException(() => InterOpKListIterator(["a", "b"], 3));
      expect(e, TypeMatcher<IndexOutOfBoundsException>());
    });

    test("remove is not implemented", () {
      final i = InterOpKListIterator(["a", "b"], 0);
      final e = catchException(() => i.remove());
      expect(e, TypeMatcher<UnimplementedError>());
    });

    test("add adds item to underlying list", () {
      var dartList = ["a", "b"];
      final i = InterOpKListIterator(dartList, 0);
      i.add("c");
      expect(dartList, equals(["c", "a", "b"]));
    });

    test("set modifies current item", () {
      var dartList = ["a", "b"];
      final i = InterOpKListIterator(dartList, 0);
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
