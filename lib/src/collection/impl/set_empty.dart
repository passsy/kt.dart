import 'package:kt_stdlib/collection.dart';
import 'package:kt_stdlib/src/collection/extension/collection_extension_mixin.dart';
import 'package:kt_stdlib/src/collection/extension/iterable_extension_mixin.dart';
import 'package:kt_stdlib/src/collection/impl/dart_iterable.dart';

class EmptySet<T>
    with KtIterableExtensionsMixin<T>, KtCollectionExtensionMixin<T>
    implements KtSet<T> {
  @override
  Set<T> get set => Set();

  @override
  bool contains(T element) => false;

  @override
  bool containsAll(KtCollection<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    return elements.isEmpty();
  }

  @override
  bool isEmpty() => true;

  @override
  KtIterator<T> iterator() => _EmptyIterator<T>();

  @override
  int get size => 0;

  @override
  bool operator ==(Object other) => other is KtSet && other.isEmpty();

  @override
  int get hashCode => 0;

  @override
  String toString() => "[]";

  @override
  Iterable<T> get iter => EmptyDartIterable();
}

class _EmptyIterator<T> extends KtIterator<T> {
  @override
  bool hasNext() => false;

  @override
  T next() {
    throw NoSuchElementException();
  }
}
