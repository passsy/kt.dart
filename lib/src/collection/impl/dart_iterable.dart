class EmptyDartIterable<T> extends Iterable<T> {
  @override
  Iterator<T> get iterator => EmptyDartIterator();
}

class EmptyDartIterator<T> extends Iterator<T> {
  @override
  T get current => null;

  @override
  bool moveNext() => false;
}
