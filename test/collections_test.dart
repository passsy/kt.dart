import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('emptyList', () {
    test("basic creation", () {
      final list = emptyList<String>();
      expect(list.size, 0);
      expect(list.hashCode, 1);
      expect(list, listOf());
      expect(list, listOf([]));
      var emptyMutable = mutableListOf(["a"])..remove("a");
      expect(list.hashCode, emptyMutable.hashCode);
      expect(list, emptyMutable);
    });
  });

  group('listOf', () {
    test("empty", () {
      final list = listOf<String>();
      expect(list.size, 0);
      expect(list.hashCode, 1);
      expect(list, listOf());
      expect(list, listOf([]));
      var emptyMutable = mutableListOf(["a"])..remove("a");
      expect(list.hashCode, emptyMutable.hashCode);
      expect(list, emptyMutable);
      expect(list, emptyList());
    });

    test("create with value", () {
      final list = listOf<String>(["test"]);
      expect(list.size, equals(1));
      expect(list, listOf(["test"]));
    });

    test("mutation of original list doesn't manipulate mutableList", () {
      final originalList = ["foo"];
      final klist = listOf<String>(originalList);
      expect(klist.size, equals(1));
      expect(klist, listOf(["foo"]));

      originalList.add("bar");
      expect(originalList, ["foo", "bar"]);
      // originalList was copied, therefore no change of klist
      expect(klist, listOf(["foo"]));
    });
  });

  group('mutableListOf', () {
    test("empty", () {
      final list = mutableListOf<String>();
      expect(list.size, 0);
      expect(list.hashCode, 1);
      expect(list, listOf());
      expect(list, listOf([]));
      var emptyMutable = mutableListOf(["a"])..remove("a");
      expect(list.hashCode, emptyMutable.hashCode);
      expect(list, emptyMutable);
      expect(list, emptyList());
    });

    test("empty is mutable", () {
      final list = mutableListOf<String>([]);
      list.add("test");
      expect(list.size, equals(1));
      expect(list, listOf(["test"]));
    });

    test("create with value", () {
      final list = mutableListOf<String>(["test"]);
      expect(list.size, equals(1));
      expect(list, listOf(["test"]));
    });

    test("mutation of original list doesn't manipulate mutableList", () {
      final originalList = ["foo"];
      final klist = mutableListOf<String>(originalList);
      expect(klist.size, equals(1));
      expect(klist, listOf(["foo"]));

      originalList.add("bar");
      expect(originalList, ["foo", "bar"]);
      // originalList was copied, therefore no change of klist
      expect(klist, listOf(["foo"]));
    });
  });

  group('hashSetOf', () {
    test("empty is mutable", () {
      final set = hashSetOf<String>([]);
      set.add("test");
      expect(set.size, equals(1));
      expect(set, setOf(["test"]));
    });

    test("empty is mutable", () {
      final set = hashSetOf<String>([]);
      set.add("test");
      expect(set.size, equals(1));
      expect(set, setOf(["test"]));
    });

    test("create with value", () {
      final set = hashSetOf<String>(["test"]);
      expect(set.size, equals(1));
      expect(set, setOf(["test"]));
    });

    test("mutation of original list doesn't manipulate mutableList", () {
      final originalList = ["foo"];
      final kset = hashSetOf<String>(originalList);
      expect(kset.size, equals(1));
      expect(kset, setOf(["foo"]));

      originalList.add("bar");
      expect(originalList, ["foo", "bar"]);
      // originalList was copied, therefore no change of klist
      expect(kset, setOf(["foo"]));
    });
  });

  group('linkedSetOf', () {
    test("empty is mutable", () {
      final set = linkedSetOf<String>([]);
      set.add("test");
      expect(set.size, equals(1));
      expect(set, setOf(["test"]));
    });

    test("empty is mutable", () {
      final set = linkedSetOf<String>([]);
      set.add("test");
      expect(set.size, equals(1));
      expect(set, setOf(["test"]));
    });

    test("create with value", () {
      final set = linkedSetOf<String>(["test"]);
      expect(set.size, equals(1));
      expect(set, setOf(["test"]));
    });

    test("mutation of original list doesn't manipulate mutableList", () {
      final originalList = ["foo"];
      final kset = linkedSetOf<String>(originalList);
      expect(kset.size, equals(1));
      expect(kset, setOf(["foo"]));

      originalList.add("bar");
      expect(originalList, ["foo", "bar"]);
      // originalList was copied, therefore no change of kset
      expect(kset, setOf(["foo"]));
    });
  });
}
