class EmptyDartIterable<T> extends Iterable<T> {
  @override
  Iterator<T> get iterator => EmptyDartIterator();
}

class EmptyDartIterator<T> extends Iterator<T> {
  @override
  T get current => throw StateError("moveNext not called or no element");

  @override
  bool moveNext() => false;
}
