import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/iterator.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  group('InterOpKListIterator', () {
    test("hasNext true", () {
      final i = InterOpKListIterator(["a", "b"], 0);
      expect(i.hasNext(), isTrue);
    });

    test("nextIndex when next exists", () {
      final i = InterOpKListIterator(["a", "b"], 0);
      expect(i.nextIndex(), 1);
    });

    test("hasNext false", () {
      final i = InterOpKListIterator(["a", "b"], 2);
      expect(i.hasNext(), isFalse);
    });

    test("nextIndex returns list size when at end", () {
      final i = InterOpKListIterator(["a", "b"], 2);
      expect(i.nextIndex(), 2);
    });

    test("start index has to be in range (smaller)", () {
      final e = catchException(() => InterOpKListIterator(["a", "b"], -1));
      expect(e, TypeMatcher<IndexOutOfBoundsException>());
    });

    test("start index has to be in range (larger)", () {
      final e = catchException(() => InterOpKListIterator(["a", "b"], 3));
      expect(e, TypeMatcher<IndexOutOfBoundsException>());
    });

    test("start index has to be in range (larger)", () {
      final i = InterOpKListIterator(["a", "b"], 0);
      //for (var char in InterOpKIterator()) {}
    });
  });
}
