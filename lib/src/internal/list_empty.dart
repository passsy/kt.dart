import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/iterable_extensions.dart';

const _kEmptyIterator = const _EmptyIterator();

class _EmptyIterator extends KListIterator<Object> {
  const _EmptyIterator();

  @override
  bool hasNext() => false;

  @override
  bool hasPrevious() => false;

  @override
  Object next() {
    throw NoSuchElementException();
  }

  @override
  int nextIndex() => 0;

  @override
  Object previous() {
    throw NoSuchElementException();
  }

  @override
  int previousIndex() => -1;
}

final kEmptyList = new _EmptyList();

class _EmptyList with KIterableExtensionsMixin<Object> implements KList<Object> {
  @override
  bool contains(Object element) => false;

  @override
  bool containsAll(KCollection<Object> elements) => false;

  @override
  Object get(int index) {
    if (index == null) throw ArgumentError("index can't be null");
    throw IndexOutOfBoundsException("Empty list doesn't contain element at index $index.");
  }

  @override
  int indexOf(Object element) => -1;

  @override
  bool isEmpty() => true;

  @override
  iterator() => _kEmptyIterator;

  @override
  int lastIndexOf(Object element) => -1;

  @override
  KListIterator<Object> listIterator([int index = 0]) {
    if (index == null) throw ArgumentError("index can't be null");
    return _kEmptyIterator;
  }

  @override
  int get size => 0;

  @override
  KList<Object> subList(int fromIndex, int toIndex) {
    if (fromIndex == null) throw ArgumentError("fromIndex can't be null");
    if (toIndex == null) throw ArgumentError("toIndex can't be null");
    if (fromIndex == 0 && toIndex == 0) return this;
    throw IndexOutOfBoundsException("fromIndex: $fromIndex, toIndex: $toIndex");
  }

  @override
  String toString() => '[]';

  @override
  int get hashCode => 1;

  @override
  bool operator ==(Object other) => other is KList && other.isEmpty();
}
