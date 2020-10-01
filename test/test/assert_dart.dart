import 'package:test/test.dart';

/// returns the caught exception thrown in [block]
T catchException<T>(Function block) {
  try {
    block();
    fail('block did not throw');
  } catch (e, stack) {
    // ignore: prefer_const_constructors
    expect(e, TypeMatcher<T>(), reason: stack.toString());
    return e as T;
  }
}
