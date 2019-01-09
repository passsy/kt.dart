import 'package:kotlin_dart/collection.dart';
import 'package:test/test.dart';

void main() {
  group("KPair", () {
    test("returns values put inside", () {
      final pair = KPair("a", "b");
      expect(pair.first, "a");
      expect(pair.second, "b");
    });

    test("equals based on items", () {
      expect(KPair("a", "b"), KPair("a", "b"));
      expect(KPair("a", "b").hashCode, KPair("a", "b").hashCode);
      expect(KPair("a", "b"), isNot(equals(KPair("a", "c"))));
      expect(KPair("a", "b").hashCode, isNot(equals(KPair("a", "c").hashCode)));
      expect(KPair("a", "b"), isNot(equals(KPair("c", "b"))));
      expect(KPair("a", "b").hashCode, isNot(equals(KPair("c", "b").hashCode)));

      expect(KPair(null, null), KPair(null, null));
      expect(KPair(null, null).hashCode, KPair(null, null).hashCode);
    });

    test("toString", () {
      expect(KPair("a", "b").toString(), "(a, b)");
      expect(KPair(null, null).toString(), "(null, null)");
    });
  });

  group("KTriple", () {
    test("returns values put inside", () {
      final pair = KTriple("a", "b", "c");
      expect(pair.first, "a");
      expect(pair.second, "b");
      expect(pair.third, "c");
    });

    test("equals based on items", () {
      expect(KTriple("a", "b", "c"), KTriple("a", "b", "c"));
      expect(KTriple("a", "b", "c").hashCode, KTriple("a", "b", "c").hashCode);
      expect(KTriple("a", "b", "c"), isNot(equals(KTriple("x", "b", "c"))));
      expect(KTriple("a", "b", "c").hashCode,
          isNot(equals(KTriple("x", "b", "c").hashCode)));
      expect(KTriple("a", "b", "c"), isNot(equals(KTriple("a", "x", "c"))));
      expect(KTriple("a", "b", "c").hashCode,
          isNot(equals(KTriple("a", "x", "c").hashCode)));
      expect(KTriple("a", "b", "c"), isNot(equals(KTriple("a", "b", "x"))));
      expect(KTriple("a", "b", "c").hashCode,
          isNot(equals(KTriple("a", "b", "x").hashCode)));

      expect(KTriple(null, null, null), KTriple(null, null, null));
      expect(KTriple(null, null, null).hashCode,
          KTriple(null, null, null).hashCode);
    });

    test("toString", () {
      expect(KTriple("a", "b", "c").toString(), "(a, b, c)");
      expect(KTriple(null, "b", null).toString(), "(null, b, null)");
    });
  });
}
