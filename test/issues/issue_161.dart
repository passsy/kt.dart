import "package:kt_dart/kt.dart";
import "package:test/test.dart";

void main() {
  // https://github.com/passsy/kt.dart/issues/161
  group("replaceFirstChar - uppercase", () {    
    test("empty string", () {
      const String phrase = "";

      final result = phrase.replaceFirstChar((it) => it.toUpperCase());

      expect(result, '');
    });
    test("'a'", () {
      const String phrase = "a";

      final result = phrase.replaceFirstChar((it) => it.toUpperCase());

      expect(result, 'A');
    });
    test("'ab'", () {
      const String phrase = "ab";

      final result = phrase.replaceFirstChar((it) => it.toUpperCase());

      expect(result, 'Ab');
    });    
  });
  group("replaceFirstChar - lowercase", () {    
    test("empty string", () {
      const String phrase = "";

      final result = phrase.replaceFirstChar((it) => it.toLowerCase());

      expect(result, '');
    });
    test("'A'", () {
      const String phrase = "A";

      final result = phrase.replaceFirstChar((it) => it.toLowerCase());

      expect(result, 'a');
    });
    test("'AB'", () {
      const String phrase = "AB";

      final result = phrase.replaceFirstChar((it) => it.toLowerCase());

      expect(result, 'aB');
    });    
  });
}