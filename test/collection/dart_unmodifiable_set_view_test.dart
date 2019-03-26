import 'package:test/test.dart';
import 'package:kt_dart/collection.dart';

import '../test/assert_dart.dart';

void main() {
  group('unmodifiable set view', () {
    test("mutation throws", () {
      final ktSet = setOf("a", "b", "c");
      final dartSet = ktSet.asSet();
      isUnmodifiable(() => dartSet.add("x"));
      isUnmodifiable(() => dartSet.addAll(["x", "y"]));
      isUnmodifiable(() => dartSet.remove("a"));
      isUnmodifiable(() => dartSet.removeAll(["a", "b"]));
      isUnmodifiable(() => dartSet.retainAll(["a"]));
      isUnmodifiable(() => dartSet.removeWhere((_) => true));
      isUnmodifiable(() => dartSet.retainWhere((_) => true));
      isUnmodifiable(() => dartSet.clear());
    });

    test("set query methods work as expected", () {
      final ktSet = setOf("a", "b", "c");
      final dartSet = ktSet.asSet();

      // Set query methods
      expect(dartSet.cast<String>(), Set.from(["a", "b", "c"]));
      expect(dartSet.containsAll(["a"]), isTrue);
      expect(dartSet.difference(Set.from(["a"])), Set.from(["b", "c"]));
      expect(dartSet.intersection(Set.from(["a", "x"])), Set.from(["a"]));
      expect(dartSet.lookup("a"), "a");
      expect(
          dartSet.union(Set.from(["a", "x"])), Set.from(["a", "b", "c", "x"]));

      // Iterable query methods inherited from IterableMixin
      expect(dartSet.map((it) => it.toUpperCase()), Set.from(["A", "B", "C"]));
      expect(dartSet.isEmpty, isFalse);
      expect(dartSet.contains("a"), isTrue);
      expect(dartSet.singleWhere((it) => it == "a"), "a");
      // ... and may more
    });

    test("asSet().toSet() offers a mutable dart Set", () {
      final ktSet = setOf("a", "b", "c");
      final dartSet = ktSet.asSet();
      final copy = dartSet.toSet();

      // copy is mutable
      copy.add("x");
      expect(copy.length, 4);

      // dartSet stays unmodified
      expect(dartSet.length, 3);

      // and dartSet is unmodifiable
      isUnmodifiable(() => dartSet.clear());
    });
  });
}

void isUnmodifiable(void Function() block) {
  final e = catchException<UnsupportedError>(block);
  expect(e.message, contains("unmodifiable"));
}
