import 'package:test/test.dart';

/// returns the caught exception thrown in [block]
T catchException<T>(Function block) {
  try {
    block();
    fail("block did not throw");
  } catch (e) {
    expect(e, TypeMatcher<T>());
    return e as T;
  }
}
