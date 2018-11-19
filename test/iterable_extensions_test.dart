import 'package:dart_kollection/src/klist.dart';
import 'package:test/test.dart';

void main() {
  group('any', () {
    test("matches single", () {
      final list = listOf(["abc", "bcd", "cde"]);
      expect(list.any((e) => e.contains("a")), isTrue);
    });
    test("matches all", () {
      final list = listOf(["abc", "bcd", "cde"]);
      expect(list.any((e) => e.contains("c")), isTrue);
    });
    test("is false when none matches", () {
      final list = listOf(["abc", "bcd", "cde"]);
      expect(list.any((e) => e.contains("x")), isFalse);
    });
  });
}
