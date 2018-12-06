import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group("first", () {
    test("get first element", () {
      expect(listOf(["a", "b"]).first(), "a");
    });

    test("first throws for no elements", () {
      expect(() => emptySet().first(),
          throwsA(TypeMatcher<NoSuchElementException>()));
      expect(() => listOf().first(),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("finds nothing throws", () {
      expect(() => setOf<String>(["a"]).first((it) => it == "b"),
          throwsA(TypeMatcher<NoSuchElementException>()));
      expect(() => listOf(["a"]).first((it) => it == "b"),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });
  });
}
