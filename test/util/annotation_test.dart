import "package:kt_dart/src/annotation/annotations.dart";
import "package:test/test.dart";

void main() {
  test("nullable is _Nullable", () {
    // ignore: deprecated_member_use_from_same_package
    expect(nullable.runtimeType.toString(), equals("_Nullable"));
  });
  test("nonNull is _NonNull", () {
    // ignore: deprecated_member_use_from_same_package
    expect(nonNull.runtimeType.toString(), equals("_NonNull"));
  });
  test("tooGeneric is TooGeneric", () {
    // ignore: deprecated_member_use_from_same_package
    expect(tooGeneric, equals(const TypeMatcher<TooGeneric>()));
  });
  test("TooGeneric has extensionForType property", () {
    // ignore: deprecated_member_use_from_same_package
    const annotation = TooGeneric(extensionForType: "SomeType");
    // ignore: deprecated_member_use_from_same_package
    expect(annotation, equals(const TypeMatcher<TooGeneric>()));
    expect(annotation.extensionForType, equals("SomeType"));
  });
}
