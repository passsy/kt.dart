import "package:kt_dart/annotation.dart";

/// An exception is thrown to indicate that a method body remains to be implemented.
@experimental
class NotImplementedException implements Exception {
  const NotImplementedException(
      [this.message = "An operation is not implemented."]);

  final String message;
}

/// Always throws [NotImplementedException] stating that operation is not implemented.
// TODO: return `Never` when nnbd is released
@experimental
// ignore: non_constant_identifier_names
void TODO() => throw const NotImplementedException();

@experimental
extension StandardKt<T> on T {
  /// Calls the specified function [block] with `this` value as its argument and returns its result.
  R let<R>(R Function(T) block) => block(this);

  /// Calls the specified function [block] with `this` value as its argument and returns `this` value.
  @experimental
  @nonNull
  T also(void Function(T) block) {
    block(this);
    return this;
  }

  /// Returns `this` value if it satisfies the given [predicate] or `null`, if it doesn't.
  @experimental
  @nullable
  T /*?*/ takeIf(bool Function(T) predicate) {
    if (predicate(this)) return this;
    return null;
  }

  /// Returns `this` value if it _does not_ satisfy the given [predicate] or `null`, if it does.
  @experimental
  @nullable
  T /*?*/ takeUnless(bool Function(T) predicate) {
    if (!predicate(this)) return this;
    return null;
  }
}

/// Executes the given function [action] specified number of [times].
///
/// A zero-based index of current iteration is passed as a parameter to [action].
@experimental
void repeat(int times, void Function(int) action) {
  for (var i = 0; i < times; i++) {
    action(i);
  }
}
