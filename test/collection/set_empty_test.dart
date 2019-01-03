import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('basic methods', () {
    test("empty iterator", () {
      final iterator = emptySet().iterator();
      expect(iterator.hasNext(), isFalse);
      expect(() => iterator.next(),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("contains nothing", () {
      final set = emptySet();
      expect(set.contains("a"), isFalse);
      expect(set.contains("b"), isFalse);
      expect(set.contains("c"), isFalse);
      expect(set.contains(null), isFalse);
      expect(set.contains(""), isFalse);
    });

    test("is empty", () {
      expect(emptySet().isEmpty(), isTrue);
    });
    test("equals although differnt types (subtypes)", () {
      expect(emptySet<int>(), emptySet<num>());
      expect(emptySet<num>(), emptySet<int>());
    });

    test("using the dart set doesn't allow mutation - empty", () {
      final kset = emptySet();
      expect(kset.isEmpty(), isTrue);
      kset.set.add("asdf");
      // unchanged
      expect(kset.isEmpty(), isTrue);
    });
  });
}
