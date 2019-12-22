import "package:kt_dart/kt.dart";
import "package:test/test.dart";

void main() {
  group("interopt", () {
    group("Iterable.kt", () {
      test("convert to KtIterable", () {
        final Iterable<int> dartIterable = Iterable.generate(3);
        final KtIterable<int> ktIterable = dartIterable.kt;
        expect(dartIterable.toList(), [0, 1, 2]);
        expect(ktIterable.toList(), listOf(0, 1, 2));
      });
    });
    group("List.kt", () {
      test("mutating kt list mutates original list", () {
        final List<int> dartList = [1, 2, 3];
        final KtMutableList<int> ktList = dartList.kt;
        expect(ktList.remove(2), isTrue);
        expect(dartList, [1, 3]);
        expect(ktList, listOf(1, 3));
      });
    });
    group("Set.kt", () {
      test("mutating kt set mutates original list", () {
        final Set<int> dartSet = {1, 2, 3};
        final KtMutableSet<int> ktSet = dartSet.kt;
        expect(ktSet.remove(2), isTrue);
        expect(dartSet, [1, 3]);
        expect(ktSet, setOf(1, 3));
      });
    });
    group("Map.kt", () {
      test("mutating kt map mutates original list", () {
        final Map<String, int> dartMap = {"a": 1, "b": 2};
        final KtMutableMap<String, int> ktMap = dartMap.kt;
        expect(ktMap.remove("a"), 1);
        expect(dartMap, {"b": 2});
        expect(ktMap, mapFrom({"b": 2}));
      });
    });

    group("Iterable.toImmutableList()", () {
      test("converts to KtList", () {
        final iterable = Iterable.generate(5);
        expect(iterable.toImmutableList(), listOf(0, 1, 2, 3, 4));
      });
    });
    group("Iterable.toImmutableSet()", () {
      test("converts to KtSet", () {
        final iterable = Iterable.generate(5);
        expect(iterable.toImmutableSet(), setOf(3, 4, 0, 1, 2));
      });
    });
    group("List.toImmutableList()", () {
      test("doesn't mutate original list", () {
        final List<int> dartList = [1, 2, 3];
        final KtMutableList<int> ktList =
            dartList.toImmutableList().toMutableList();
        expect(ktList.remove(2), isTrue);
        expect(dartList, [1, 2, 3]);
        expect(ktList, listOf(1, 3));
      });
    });
    group("Set.toImmutableList()", () {
      test("doesn't mutate original set", () {
        final Set<int> dartSet = {1, 2, 3};
        final KtMutableSet<int> ktSet =
            dartSet.toImmutableList().toMutableSet();
        expect(ktSet.remove(2), isTrue);
        expect(dartSet, [1, 2, 3]);
        expect(ktSet, setOf(1, 3));
      });
    });
    group("Map.toImmutableList()", () {
      test("doesn't mutate original map", () {
        final Map<String, int> dartMap = {"a": 1, "b": 2};
        final KtMutableMap<String, int> ktMap =
            dartMap.toImmutableList().toMutableMap();
        expect(ktMap.remove("a"), 1);
        expect(dartMap, {"a": 1, "b": 2});
        expect(ktMap, mapFrom({"b": 2}));
      });
    });
  });
}
