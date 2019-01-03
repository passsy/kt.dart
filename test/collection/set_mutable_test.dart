import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

import '../test/assert_dart.dart';

void main() {
  test("linkedSetOf automatically removes duplicates", () {
    final set = linkedSetOf(["a", "b", "a", "c"]);
    expect(set.size, 3);
  });

  test("hashSetOf automatically removes duplicates", () {
    final set = hashSetOf(["a", "b", "a", "c"]);
    expect(set.size, 3);
  });

  test("linkedSetOf iterates in order as specified", () {
    final set = linkedSetOf(["a", "b", "c"]);
    final iterator = set.iterator();
    expect(iterator.hasNext(), isTrue);
    expect(iterator.next(), "a");
    expect(iterator.hasNext(), isTrue);
    expect(iterator.next(), "b");
    expect(iterator.hasNext(), isTrue);
    expect(iterator.next(), "c");
    expect(iterator.hasNext(), isFalse);
    final e = catchException(() => iterator.next());
    expect(e, TypeMatcher<NoSuchElementException>());
  });

  test("using the internal dart set allows mutation - empty", () {
    final kset = linkedSetOf();
    expect(kset.isEmpty(), isTrue);
    kset.set.add("asdf");
    // unchanged
    expect(kset.isEmpty(), isFalse);
    expect(kset, setOf(["asdf"]));
  });

  test("using the internal dart set allows mutation", () {
    final kset = linkedSetOf(["a"]);
    expect(kset, setOf(["a"]));
    kset.set.add("b");
    // unchanged
    expect(kset, setOf(["a", "b"]));
  });

  test("clear", () {
    final list = linkedSetOf(["a", "b", "c"]);
    list.clear();
    expect(list.isEmpty(), isTrue);
  });

  group("remove", () {
    test("remove item when found", () {
      final list = linkedSetOf(["a", "b", "c"]);
      final result = list.remove("b");
      expect(list, setOf(["a", "c"]));
      expect(result, isTrue);
    });
    test("don't remove item when not found", () {
      final list = linkedSetOf(["a", "b", "c"]);
      final result = list.remove("x");
      expect(list, setOf(["a", "b", "c"]));
      expect(result, isFalse);
    });
  });

  group("removeAll", () {
    test("remove item when found", () {
      final list = linkedSetOf(["paul", "john", "max", "lisa"]);
      final result = list.removeAll(listOf(["paul", "max"]));
      expect(list, setOf(["john", "lisa"]));
      expect(result, isTrue);
    });
    test("remove only found when found", () {
      final list = linkedSetOf(["paul", "john", "max", "lisa"]);
      final result = list.removeAll(listOf(["paul", "max", "tony"]));
      expect(list, setOf(["john", "lisa"]));
      expect(result, isTrue);
    });

    test("removeAll requires elements to be non null", () {
      final e =
          catchException<ArgumentError>(() => linkedSetOf().removeAll(null));
      expect(e.message, allOf(contains("null"), contains("elements")));
    });
  });
}
