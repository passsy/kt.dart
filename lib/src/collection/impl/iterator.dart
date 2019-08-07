import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/kt_iterator_mutable.dart";

class InterOpKtIterator<T> implements KtIterator<T> {
  InterOpKtIterator(this.iterator) {
    _hasNext = iterator.moveNext();
    _nextValue = iterator.current;
  }

  final Iterator<T> iterator;
  T _nextValue;
  bool _hasNext;

  @override
  bool hasNext() => _hasNext;

  @override
  T next() {
    if (!_hasNext) throw const NoSuchElementException();
    final e = _nextValue;
    _hasNext = iterator.moveNext();
    _nextValue = iterator.current;
    return e;
  }
}

class InterOpKtListIterator<T>
    implements KtListIterator<T>, KtMutableListIterator<T> {
  InterOpKtListIterator(this._list, int index) : _cursor = index {
    if (index < 0 || index > _list.length) {
      throw IndexOutOfBoundsException("index: $index, size: $_list.length");
    }
  }

  int _cursor; // index of next element to return
  int _lastRet = -1; // index of last element returned; -1 if no such
  List<T> _list;

  @override
  bool hasNext() => _cursor != _list.length;

  @override
  T next() {
    final i = _cursor;
    if (i >= _list.length) throw const NoSuchElementException();
    _cursor = i + 1;
    return _list[_lastRet = i];
  }

  @override
  void remove() {
    // removing from list is wrong because is is a copy of the original list.
    // remove should modify the underlying list, not the copy
    // see how kotlin solved this:
    // https://github.com/JetBrains/kotlin/blob/ba6da7c40a6cc502508faf6e04fa105b96bc7777/libraries/stdlib/js/src/kotlin/collections/InternalHashCodeMap.kt
    throw UnimplementedError(
        "remove() in not yet implemented. Please vote for https://github.com/passsy/dart_kollection/issues/5 for prioritization");
  }

  @override
  bool hasPrevious() => _cursor != 0;

  @override
  int nextIndex() => _cursor + 1 > _list.length ? _list.length : _cursor;

  @override
  T previous() {
    if (!hasPrevious()) throw const NoSuchElementException();
    return _list[--_cursor];
  }

  @override
  int previousIndex() => _cursor - 1;

  @override
  void add(T element) {
    final i = _cursor;
    _list.insert(i, element);
    _lastRet = -1;
    _cursor = i + 1;
  }

  @override
  void set(T element) {
    if (_lastRet < 0) {
      throw const IndexOutOfBoundsException(
          "illegal cursor state -1. next() or previous() not called");
    }
    _list.replaceRange(_lastRet, _lastRet + 1, [element]);
  }
}
