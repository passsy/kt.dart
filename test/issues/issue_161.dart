import "package:kt_dart/kt.dart";
import "package:test/test.dart";

void main() {
  // https://github.com/passsy/kt.dart/issues/161
  group("replaceFirstChar", () {
    test("uppercase", () {
      const String phrase = "hacktoberfest";

      final result = phrase.replaceFirstChar((it) => it.toUpperCase());

      expect(result, 'Hacktoberfest');
    });
    test("uppercase - empty string", () {
      const String phrase = "";

      final result = phrase.replaceFirstChar((it) => it.toUpperCase());

      expect(result, '');
    });
    test("lowercase", () {
      const String phrase = "Hacktoberfest";

      final result = phrase.replaceFirstChar((it) => it.toLowerCase());

      expect(result, 'hacktoberfest');
    });
    test("lowercase - empty string", () {
      const String phrase = "";

      final result = phrase.replaceFirstChar((it) => it.toLowerCase());

      expect(result, '');
    });
  });
}
