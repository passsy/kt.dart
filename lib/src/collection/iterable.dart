class DartEmptyIterable<T> extends Iterable<T> {
  @override
  Iterator<T> get iterator => DartEmptyIterator();
}

class DartEmptyIterator<T> extends Iterator<T> {
  @override
  T get current => null;

  @override
  bool moveNext() => false;
}
