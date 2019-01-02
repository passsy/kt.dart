import 'package:dart_kollection/src/util/hash.dart';
import 'package:test/test.dart';

void main() {
  test("hash2", () {
    expect(hash2("foo", "bar"), equals(422905972));
    expect(hashObjects(["foo", "bar"]), equals(422905972));
    expect(hash2("bar", "foo"), equals(293502445));
    expect(hashObjects(["bar", "foo"]), equals(293502445));
  });
  test("hash3", () {
    expect(hash3("foo", "bar", "baz"), equals(247754790));
    expect(hashObjects(["foo", "bar", "baz"]), equals(247754790));
    expect(hash3("baz", "bar", "foo"), equals(413548564));
    expect(hashObjects(["baz", "bar", "foo"]), equals(413548564));
  });
  test("hash4", () {
    expect(hash4("foo", "bar", "baz", "qux"), equals(263375993));
    expect(hashObjects(["foo", "bar", "baz", "qux"]), equals(263375993));
    expect(hash4("baz", "bar", "foo", "qux"), equals(264235936));
    expect(hashObjects(["baz", "bar", "foo", "qux"]), equals(264235936));
  });
}
