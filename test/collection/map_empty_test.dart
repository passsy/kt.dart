import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('empty map', () {
    test("has no elements", () {
      final empty = emptyMap<String, Object>();
      expect(empty.size, equals(0));
    });

    test("contains nothing", () {
      expect(emptyMap<String, String>().containsKey("asdf"), isFalse);
      expect(emptyMap<String, String>().containsValue("asdf"), isFalse);
      expect(emptyMap<int, int>().containsKey(null), isFalse);
      expect(emptyMap<int, int>().containsValue(null), isFalse);
      expect(emptyMap<int, int>().containsKey(0), isFalse);
      expect(emptyMap<int, int>().containsValue(0), isFalse);
      expect(emptyMap<List, List>().containsKey([]), isFalse);
      expect(emptyMap<List, List>().containsValue([]), isFalse);
    });

    test("values iterator has no next", () {
      final empty = emptyMap();
      expect(empty.values.iterator().hasNext(), isFalse);
      expect(() => empty.values.iterator().next(),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("keys iterator has no next", () {
      final empty = emptyMap();
      expect(empty.keys.iterator().hasNext(), isFalse);
      expect(() => empty.keys.iterator().next(),
          throwsA(TypeMatcher<NoSuchElementException>()));
    });

    test("is empty", () {
      final empty = emptyMap<String, Object>();

      expect(empty.isEmpty(), isTrue);
    });

    test("get always returns null", () {
      final empty = emptyMap();

      expect(empty.get(0), isNull);
      expect(empty.get(1), isNull);
      expect(empty.get(-1), isNull);
      expect(empty.get(null), isNull);
    });

    test("is equals to another empty map", () {
      final empty0 = emptyMap();
      final empty1 = emptyMap();

      expect(empty0, equals(empty1));
      expect(empty0.hashCode, equals(empty1.hashCode));
    });

    test("empty lists of different type are equal", () {
      final empty0 = emptyMap<int, String>();
      final empty1 = emptyMap<String, Object>();

      expect(empty0, equals(empty1));
      expect(empty0.hashCode, equals(empty1.hashCode));
    });

    test("is same as empty mutable map", () {
      final empty0 = emptyMap<int, String>();
      final empty1 = mutableMapOf();

      expect(empty0, equals(empty1));
      expect(empty0.hashCode, equals(empty1.hashCode));
    });

    test("access dart map", () {
      final Map<String, int> map = emptyMap<String, int>().map;
      expect(map.length, 0);
    });
  });
}
