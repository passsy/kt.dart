class IndexOutOfBoundsException implements Exception {
  final String message;

  IndexOutOfBoundsException(this.message);

  @override
  String toString() => 'IndexOutOfBoundsException: $message';
}

class NoSuchElementException implements Exception {}
