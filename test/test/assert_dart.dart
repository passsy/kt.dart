import 'package:test/test.dart';

/// returns the caught exception thrown in [block]
dynamic catchException(Function block) {
  try {
    block();
    fail("block did not throw");
  } catch (e) {
    return e;
  }
}
