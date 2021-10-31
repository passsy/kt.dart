/// An element annotated with @nullable claims <code>null</code> value is perfectly <em>valid</em>
/// to return (for methods), pass to (parameters) and hold (local variables and fields).
///
/// Apart from documentation purposes this annotation is intended to be used by static analysis tools
/// to validate against probable runtime errors and element contract violations.
@Deprecated("Dart not support non-nullable types")
const Object nullable = _Nullable();

@Deprecated("Dart not support non-nullable types")
class _Nullable {
  @Deprecated("Dart not support non-nullable types")
  const _Nullable();
}

/// An element annotated with @notNull claims <code>null</code> value is <em>forbidden</em>
/// to return (for methods), pass to (parameters) and hold (local variables and fields).
///
/// Apart from documentation purposes this annotation is intended to be used by static analysis tools
/// to validate against probable runtime errors and element contract violations.
@Deprecated("Dart not support non-nullable types")
const Object nonNull = _NonNull();

@Deprecated("Dart not support non-nullable types")
class _NonNull {
  @Deprecated("Dart not support non-nullable types")
  const _NonNull();
}

/// A method annotated with @tooGeneric is a indicator that the method is defined for a generic type `T` but only works for type `X` where `X extends T`.
///
/// The method will be moved to a more specific type when dart extension methods are implemented.
/// https://github.com/dart-lang/language/issues/41
///
/// Use `@TooGeneric(type: X)` to define which type should be used
@Deprecated("Use static extension methods")
const Object tooGeneric = TooGeneric();

/// A method annotated with @tooGeneric is a indicator that the method is defined for a generic type `T` but only works for type `X` where `X extends T`.
///
/// The method will be moved to a more specific type when dart extension methods are implemented.
/// https://github.com/dart-lang/language/issues/41
///
/// Use `@TooGeneric(type: X)` to define which type should be used
@Deprecated("Use static extension methods")
class TooGeneric {
  @Deprecated("Use static extension methods")
  const TooGeneric({this.extensionForType});

  /// The type which would be a better fit
  final String? extensionForType;
}
