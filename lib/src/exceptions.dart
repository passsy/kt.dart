@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
class IndexOutOfBoundsException implements Exception {
  IndexOutOfBoundsException([this.message]);

  final String message;

  @override
  String toString() => message == null
      ? 'IndexOutOfBoundsException'
      : 'IndexOutOfBoundsException: $message';
}

@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
class NoSuchElementException implements Exception {
  NoSuchElementException([this.message]);

  final String message;

  @override
  String toString() => message == null
      ? 'NoSuchElementException'
      : 'NoSuchElementException: $message';
}
