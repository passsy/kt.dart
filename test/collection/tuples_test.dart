// ignore_for_file: prefer_const_constructors
import "package:kt_dart/collection.dart";
import "package:test/test.dart";

void main() {
  group("KtPair", () {
    test("can be const", () {
      const a = KtPair("a", "b");
      const b = KtPair("a", "b");
      expect(identical(a, b), isTrue);
    });

    test("returns values put inside", () {
      final pair = KtPair("a", "b");
      expect(pair.first, "a");
      expect(pair.second, "b");
    });

    test("equals based on items", () {
      final p1 = KtPair("a", "b");
      final p2 = KtPair("a", "b");
      expect(identical(p1, p2), isFalse);
      expect(p1, p2);

      expect(KtPair("a", "b").hashCode, KtPair("a", "b").hashCode);
      expect(KtPair("a", "b"), isNot(equals(KtPair("a", "c"))));
      expect(
          KtPair("a", "b").hashCode, isNot(equals(KtPair("a", "c").hashCode)));
      expect(KtPair("a", "b"), isNot(equals(KtPair("c", "b"))));
      expect(
          KtPair("a", "b").hashCode, isNot(equals(KtPair("c", "b").hashCode)));

      expect(KtPair(null, null), KtPair(null, null));
      expect(KtPair(null, null).hashCode, KtPair(null, null).hashCode);
    });

    test("toString", () {
      expect(KtPair("a", "b").toString(), "(a, b)");
      expect(KtPair(null, null).toString(), "(null, null)");
    });
  });

  group("KtTriple", () {
    test("returns values put inside", () {
      final pair = KtTriple("a", "b", "c");
      expect(pair.first, "a");
      expect(pair.second, "b");
      expect(pair.third, "c");
    });

    test("can be const", () {
      const a = KtTriple("a", "b", "c");
      const b = KtTriple("a", "b", "c");
      expect(identical(a, b), isTrue);
    });

    test("equals based on items", () {
      expect(KtTriple("a", "b", "c"), KtTriple("a", "b", "c"));
      expect(
          KtTriple("a", "b", "c").hashCode, KtTriple("a", "b", "c").hashCode);
      expect(KtTriple("a", "b", "c"), isNot(equals(KtTriple("x", "b", "c"))));
      expect(KtTriple("a", "b", "c").hashCode,
          isNot(equals(KtTriple("x", "b", "c").hashCode)));
      expect(KtTriple("a", "b", "c"), isNot(equals(KtTriple("a", "x", "c"))));
      expect(KtTriple("a", "b", "c").hashCode,
          isNot(equals(KtTriple("a", "x", "c").hashCode)));
      expect(KtTriple("a", "b", "c"), isNot(equals(KtTriple("a", "b", "x"))));
      expect(KtTriple("a", "b", "c").hashCode,
          isNot(equals(KtTriple("a", "b", "x").hashCode)));

      expect(KtTriple(null, null, null), KtTriple(null, null, null));
      expect(KtTriple(null, null, null).hashCode,
          KtTriple(null, null, null).hashCode);
    });

    test("toString", () {
      expect(KtTriple("a", "b", "c").toString(), "(a, b, c)");
      expect(KtTriple(null, "b", null).toString(), "(null, b, null)");
    });
  });
}
