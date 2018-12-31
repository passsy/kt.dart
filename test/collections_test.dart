import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('emptyList', () {
    test("basic creation", () {
      final list = emptyList<String>();
      expect(list.size, 0);
      expect(list.hashCode, 1);
      expect(list, listFrom());
      expect(list, listOf());
      var emptyMutable = mutableListOf("a")..remove("a");
      expect(list.hashCode, emptyMutable.hashCode);
      expect(list, emptyMutable);
    });
  });

  group('listFrom', () {
    test("empty", () {
      final list = listFrom<String>();
      expect(list.size, 0);
      expect(list.hashCode, 1);
      expect(list, listFrom());
      expect(list, listOf());
      var emptyMutable = mutableListOf("a")..remove("a");
      expect(list.hashCode, emptyMutable.hashCode);
      expect(list, emptyMutable);
      expect(list, emptyList());
    });

    test("create with value", () {
      final list = listFrom<String>(["test"]);
      expect(list.size, equals(1));
      expect(list, listOf("test"));
    });

    test("mutation of original list doesn't manipulate mutableList", () {
      final originalList = ["foo"];
      final klist = listFrom<String>(originalList);
      expect(klist.size, equals(1));
      expect(klist, listOf("foo"));

      originalList.add("bar");
      expect(originalList, ["foo", "bar"]);
      // originalList was copied, therefore no change of klist
      expect(klist, listOf("foo"));
    });
  });

  group('mutableListFrom', () {
    test("empty", () {
      final list = mutableListOf<String>();
      expect(list.size, 0);
      expect(list.hashCode, 1);
      expect(list, listFrom());
      expect(list, listOf());
      var emptyMutable = mutableListOf("a")..remove("a");
      expect(list.hashCode, emptyMutable.hashCode);
      expect(list, emptyMutable);
      expect(list, emptyList());
    });

    test("empty is mutable", () {
      final list = mutableListFrom<String>([]);
      list.add("test");
      expect(list.size, equals(1));
      expect(list, listOf("test"));
    });

    test("create with value", () {
      final list = mutableListFrom<String>(["test"]);
      expect(list.size, equals(1));
      expect(list, listOf("test"));
    });

    test("mutation of original list doesn't manipulate mutableList", () {
      final originalList = ["foo"];
      final klist = mutableListFrom<String>(originalList);
      expect(klist.size, equals(1));
      expect(klist, listOf("foo"));

      originalList.add("bar");
      expect(originalList, ["foo", "bar"]);
      // originalList was copied, therefore no change of klist
      expect(klist, listOf("foo"));
    });
  });

  group("hashMapOf", () {
    test("empty is mutable", () {
      final map = hashMapOf<int, String>();
      map[1] = "a";
      expect(map.size, 1);
      expect(map, mapOf({1: "a"}));
    });

    test("with empty map is mutable", () {
      final map = hashMapOf<int, String>({});
      map[1] = "a";
      expect(map.size, 1);
      expect(map, mapOf({1: "a"}));
    });

    test("mutation of original list doesn't manipulate original map", () {
      var initialMap = {
        1: "Bulbasaur",
        2: "Ivysaur",
      };
      final map = hashMapOf<int, String>(initialMap);
      map[1] = "a";
      expect(map.size, 2);
      expect(map, mapOf({1: "a", 2: "Ivysaur"}));

      // original is unchanged
      expect(initialMap[1], "Bulbasaur");
    });
  });

  group('hashSetOf', () {
    test("empty is mutable", () {
      final set = hashSetOf<String>();
      set.add("test");
      expect(set.size, equals(1));
      expect(set, setOf(["test"]));
    });

    test("with empty list is mutable", () {
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
