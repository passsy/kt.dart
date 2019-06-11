import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/extension/collection_extension_mixin.dart';
import 'package:kt_dart/src/collection/extension/iterable_extension_mixin.dart';
import 'package:kt_dart/src/collection/impl/dart_iterable.dart';
import 'package:kt_dart/src/collection/impl/dart_unmodifiable_set_view.dart';

class EmptySet<T> extends Object
    with KtIterableExtensionsMixin<T>, KtCollectionExtensionMixin<T>
    implements KtSet<T> {
  @override
  Set<T> get set => UnmodifiableSetView(Set());

  @override
  Set<T> asSet() => UnmodifiableSetView(Set());

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
