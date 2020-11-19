// ignore_for_file: unnecessary_cast, (dart 2.6 need some help in extensions)
import 'package:meta/meta.dart' show experimental;

/// An exception is thrown to indicate that a method body remains to be implemented.
@experimental
class NotImplementedException implements Exception {
  NotImplementedException([String? message])
      : message = message ?? "An operation is not implemented.";

  final String message;

  @override
  String toString() => "Exception: $message";
}

/// Always throws [NotImplementedException] stating that operation is not implemented.
// TODO: return `Never` when nnbd is released
@pragma('vm:prefer-inline')
@pragma('dart2js:tryInline')
@experimental
// ignore: non_constant_identifier_names
Never TODO([String? reason]) => throw NotImplementedException(reason);

@experimental
extension StandardKt<T> on T {
  /// Calls the specified function [block] with `this` value as its argument and returns its result.
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  R let<R>(R Function(T) block) {
    return block(this as T);
  }

  /// Calls the specified function [block] with `this` value as its argument and returns `this` value.
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @experimental
  T also(void Function(T) block) {
    block(this as T);
    return this as T;
  }

  /// Returns `this` value if it satisfies the given [predicate] or `null`, if it doesn't.
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @experimental
  T? takeIf(bool Function(T) predicate) {
    if (predicate(this as T)) return this as T;
    return null;
  }

  /// Returns `this` value if it _does not_ satisfy the given [predicate] or `null`, if it does.
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @experimental
  T? takeUnless(bool Function(T) predicate) {
    if (!predicate(this as T)) return this as T;
    return null;
  }
}

/// Executes the given function [action] specified number of [times].
///
/// A zero-based index of current iteration is passed as a parameter to [action].
@pragma('vm:prefer-inline')
@pragma('dart2js:tryInline')
@experimental
void repeat(int times, void Function(int) action) {
  for (var i = 0; i < times; i++) {
    action(i);
  }
}
