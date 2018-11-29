import 'package:dart_kollection/dart_kollection.dart';
import 'package:test/test.dart';

void main() {
  group('basic methods', () {
    test("access dart map", () {
      Map<String, int> map = mapOf<String, int>({"a": 1, "b": 2}).map;
      expect(map.length, 2);
      expect(map, equals({"a": 1, "b": 2}));
    });
  });
}
