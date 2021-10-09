import "package:kt_dart/kt.dart";
import "package:test/test.dart";

void main() {
  // https://github.com/passsy/kt.dart/issues/161
  group("issue #161", () {
    test("capitalize", () {
      const String phrase = "hacktoberfest";

      final result = phrase.replaceFirstChar(() => phrase.capitalize());

      expect(result, 'Hacktoberfest');
    });
    test("uppercase - empty string", () {
      const String phrase = "";

      final result = phrase.replaceFirstChar(() => phrase.capitalize());

      expect(result, '');
    });
    test("lowcase", () {
      const String phrase = "Hacktoberfest";

      final result = phrase.replaceFirstChar(() => phrase.lowercase());

      expect(result, 'hacktoberfest');
    });
    test("lowcase - empty string", () {
      const String phrase = "";

      final result = phrase.replaceFirstChar(() => phrase.lowercase());

      expect(result, '');
    });
  });
}
