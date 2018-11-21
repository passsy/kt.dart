class IndexOutOfBoundsException implements Exception {
  final String message;

  IndexOutOfBoundsException([this.message]);

  @override
  String toString() => message == null ? 'IndexOutOfBoundsException' : 'IndexOutOfBoundsException: $message';
}

class NoSuchElementException implements Exception {
  final String message;

  NoSuchElementException([this.message]);

  @override
  String toString() => message == null ? 'NoSuchElementException' : 'NoSuchElementException: $message';
}
