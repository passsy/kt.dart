import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/dart_iterable.dart';
import 'package:dart_kollection/src/extension/collection_extension_mixin.dart';
import 'package:dart_kollection/src/extension/iterable_extension_mixin.dart';
import 'package:dart_kollection/src/extension/list_extension_mixin.dart';

class EmptyList<T>
    with
        KIterableExtensionsMixin<T>,
        KCollectionExtensionMixin<T>,
        KListExtensionsMixin<T>
    implements KList<T> {
  @override
  List<T> get list => <T>[];

  @override
  bool contains(T element) => false;

  @override
  bool containsAll(KCollection<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    return elements.isEmpty();
  }

  @override
  T get(int index) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    throw IndexOutOfBoundsException(
        "Empty list doesn't contain element at index: $index.");
  }

  @override
  T operator [](int index) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    throw IndexOutOfBoundsException(
        "Empty list doesn't contain element at index: $index.");
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
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    return _EmptyIterator();
  }

  @override
  int get size => 0;

  @override
  KList<T> subList(int fromIndex, int toIndex) {
    assert(() {
      if (fromIndex == null) throw ArgumentError("fromIndex can't be null");
      if (toIndex == null) throw ArgumentError("toIndex can't be null");
      return true;
    }());
    if (fromIndex == 0 && toIndex == 0) return this;
    throw IndexOutOfBoundsException(
        "fromIndex: $fromIndex, toIndex: $toIndex, size: $size");
  }

  @override
  String toString() => '[]';

  @override
  int get hashCode => 1;

  @override
  bool operator ==(Object other) => other is KList && other.isEmpty();

  @override
  Iterable<T> get iter => EmptyDartIterable();
}

class _EmptyIterator<T> extends KListIterator<T> {
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
