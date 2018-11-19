import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/iterable_extensions.dart';

class _EmptyIterator<T> extends KListIterator<T> {
  const _EmptyIterator();

  @override
  bool hasNext() => false;

  @override
  bool hasPrevious() => false;

  @override
  T next() {
    throw NoSuchElementException();
  }

  @override
  int nextIndex() => 0;

  @override
  T previous() {
    throw NoSuchElementException();
  }

  @override
  int previousIndex() => -1;
}

class EmptyList<T> with KIterableExtensionsMixin<T> implements KList<T> {
  @override
  bool contains(T element) => false;

  @override
  bool containsAll(KCollection<T> elements) => elements.isEmpty();

  @override
  T get(int index) {
    if (index == null) throw ArgumentError("index can't be null");
    throw IndexOutOfBoundsException("Empty list doesn't contain element at index $index.");
  }

  @override
  T operator [](int index) {
    if (index == null) throw ArgumentError("index can't be null");
    throw IndexOutOfBoundsException("Empty list doesn't contain element at index $index.");
  }

  @override
  int indexOf(T element) => -1;

  @override
  bool isEmpty() => true;

  @override
  KIterator<T> iterator() => _EmptyIterator();

  @override
  int lastIndexOf(T element) => -1;

  @override
  KListIterator<T> listIterator([int index = 0]) {
    if (index == null) throw ArgumentError("index can't be null");
    return _EmptyIterator();
  }

  @override
  int get size => 0;

  @override
  KList<T> subList(int fromIndex, int toIndex) {
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
