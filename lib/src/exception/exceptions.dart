class IndexOutOfBoundsException implements Exception {
  const IndexOutOfBoundsException([this.message]);

  final String? message;

  @override
  String toString() => message == null
      ? "IndexOutOfBoundsException"
      : "IndexOutOfBoundsException: $message";
}

class NoSuchElementException implements Exception {
  const NoSuchElementException([this.message]);

  final String? message;

  @override
  String toString() => message == null
      ? "NoSuchElementException"
      : "NoSuchElementException: $message";
}
