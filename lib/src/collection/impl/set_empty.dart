import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/impl/dart_iterable.dart';
import 'package:kt_dart/src/collection/impl/dart_unmodifiable_set_view.dart';

class EmptySet<T> extends Object implements KtSet<T> {
  const EmptySet();

  @override
  Set<T> get set => UnmodifiableSetView(<T>{});

  @override
  Set<T> asSet() => UnmodifiableSetView(<T>{});

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
  String toString() => '[]';

  @override
  Iterable<T> get iter => EmptyDartIterable();
}

class _EmptyIterator<T> implements KtIterator<T> {
  @override
  bool hasNext() => false;

  @override
  T next() {
    throw const NoSuchElementException();
  }
}
