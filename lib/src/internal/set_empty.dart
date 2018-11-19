import 'package:dart_kollection/dart_kollection.dart';

import 'iterable_extensions.dart';

final KSet<Object> kEmptySet = new _EmptySet();

class _EmptySet with KIterableExtensionsMixin<Object> implements KSet<Object> {
  @override
  bool contains(Object element) => false;

  @override
  bool containsAll(KCollection<Object> elements) => elements.isEmpty();

  @override
  bool isEmpty() => true;

  @override
  KIterator<Object> iterator() => _kEmptyIterator;

  @override
  int get size => 0;

  @override
  bool operator ==(Object other) => other is KSet && other.isEmpty();

  @override
  int get hashCode => 0;

  @override
  String toString() => "[]";
}

const _kEmptyIterator = const _EmptyIterator();

class _EmptyIterator<T> extends KIterator<T> {
  const _EmptyIterator();

  @override
  bool hasNext() => false;

  @override
  T next() {
    throw NoSuchElementException();
  }
}
