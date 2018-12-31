class IndexOutOfBoundsException implements Exception {
  IndexOutOfBoundsException([this.message]);

  final String message;

  @override
  String toString() => message == null
      ? 'IndexOutOfBoundsException'
      : 'IndexOutOfBoundsException: $message';
}

class NoSuchElementException implements Exception {
  NoSuchElementException([this.message]);

  final String message;

  @override
  String toString() => message == null
      ? 'NoSuchElementException'
      : 'NoSuchElementException: $message';
}
