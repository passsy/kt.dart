import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/iterable.dart';
import 'package:dart_kollection/src/internal/collection_extension_mixin.dart';

import 'iterable_extension_mixin.dart';

class EmptySet<T> with KCollectionExtensionMixin<T>, KIterableExtensionsMixin<T> implements KSet<T> {
  @override
  bool contains(T element) => false;

  @override
  bool containsAll(KCollection<T> elements) => elements.isEmpty();

  @override
  bool isEmpty() => true;

  @override
  KIterator<T> iterator() => _EmptyIterator<T>();

  @override
  int get size => 0;

  @override
  bool operator ==(Object other) => other is KSet && other.isEmpty();

  @override
  int get hashCode => 0;

  @override
  String toString() => "[]";

  @override
  Iterable<T> get iter => DartIterable(this);
}

class _EmptyIterator<T> extends KIterator<T> {
  const _EmptyIterator();

  @override
  bool hasNext() => false;

  @override
  T next() {
    throw NoSuchElementException();
  }
}
