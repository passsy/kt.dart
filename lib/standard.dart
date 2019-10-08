/// An exception is thrown to indicate that a method body remains to be implemented.
class NotImplementedException implements Exception {
  const NotImplementedException(
      [this.message = "An operation is not implemented."]);

  final String message;
}

/// Always throws [NotImplementedError] stating that operation is not implemented.
// TODO: return `Never` when nnbd is released
// ignore: non_constant_identifier_names
void TODO() => throw const NotImplementedException();

extension StandardKt<T> on T {
  /// Calls the specified function [block] with `this` value as its argument and returns its result.
  R let<R>(R Function(T) block) => block(this);

  /// Calls the specified function [block] with `this` value as its argument and returns `this` value.
  T also(void Function(T) block) {
    block(this);
    return this;
  }

  /// Returns `this` value if it satisfies the given [predicate] or `null`, if it doesn't.
  T /*?*/ takeIf(bool Function(T) predicate) {
    if (predicate(this)) return this;
    return null;
  }

  /// Returns `this` value if it _does not_ satisfy the given [predicate] or `null`, if it does.
  T /*?*/ takeUnless(bool Function(T) predicate) {
    if (!predicate(this)) return this;
    return null;
  }
}

/// Calls the specified function [block] and returns its result.
R run<R>(R Function() block) => block();

/// Executes the given function [action] specified number of [times].
///
/// A zero-based index of current iteration is passed as a parameter to [action].
void repeat(int times, void Function(int) action) {
  for (var i = 0; i < times; i++) {
    action(i);
  }
}
