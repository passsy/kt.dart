import "package:kt_dart/kt.dart";
import "package:test/test.dart";

void main() {
  // https://github.com/passsy/kt.dart/issues/111
  test("issue #111", () {
    listOf(1, 2, 3).sortedBy((n) => n);
  });
}
