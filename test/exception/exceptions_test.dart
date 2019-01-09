import 'package:kotlin_dart/collection.dart';
import 'package:test/test.dart';

void main() {
  group("IndexOutOfBoundsException", () {
    test("toString with message", () {
      final e = IndexOutOfBoundsException("orange juice");
      expect(e.toString(), "IndexOutOfBoundsException: orange juice");
    });

    test("toString without message", () {
      final e = IndexOutOfBoundsException();
      expect(e.toString(), "IndexOutOfBoundsException");
    });
  });

  group("NoSuchElementException", () {
    test("toString with message", () {
      final e = NoSuchElementException("orange juice");
      expect(e.toString(), "NoSuchElementException: orange juice");
    });

    test("toString without message", () {
      final e = NoSuchElementException();
      expect(e.toString(), "NoSuchElementException");
    });
  });
}
