import 'package:kt_stdlib/src/annotation/annotations.dart';
import 'package:test/test.dart';

void main() {
  test("nullable is _Nullable", () {
    expect(nullable.runtimeType.toString(), equals("_Nullable"));
  });
  test("nonNull is _NonNull", () {
    expect(nonNull.runtimeType.toString(), equals("_NonNull"));
  });
  test("tooGeneric is TooGeneric", () {
    expect(tooGeneric, equals(const TypeMatcher<TooGeneric>()));
  });
  test("TooGeneric has extensionForType property", () {
    const annotation = TooGeneric(extensionForType: "SomeType");
    expect(annotation, equals(const TypeMatcher<TooGeneric>()));
    expect(annotation.extensionForType, equals("SomeType"));
  });
}
