import "package:kt_dart/kt.dart";
import "package:test/test.dart";

void main() {
  group("replaceFirstChar", () {
    group("uppercase", () {
      test("empty string", () {
        const String phrase = "";
        final result = phrase.replaceFirstChar((it) => it.toUpperCase());
        expect(result, '');
      });
      test("length 1", () {
        const String phrase = "a";
        final result = phrase.replaceFirstChar((it) => it.toUpperCase());
        expect(result, 'A');
      });
      test("length 2", () {
        const String phrase = "ab";
        final result = phrase.replaceFirstChar((it) => it.toUpperCase());
        expect(result, 'Ab');
      });
    });
    group("lowercase", () {
      test("empty string", () {
        const String phrase = "";
        final result = phrase.replaceFirstChar((it) => it.toLowerCase());
        expect(result, '');
      });
      test("length 1", () {
        const String phrase = "A";
        final result = phrase.replaceFirstChar((it) => it.toLowerCase());
        expect(result, 'a');
      });
      test("length 2", () {
        const String phrase = "AB";
        final result = phrase.replaceFirstChar((it) => it.toLowerCase());
        expect(result, 'aB');
      });
    });
  });
}
