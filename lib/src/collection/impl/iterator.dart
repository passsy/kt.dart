import "package:kt_dart/collection.dart";

class InterOpKIterator<T> implements KtIterator<T> {
  InterOpKIterator(this.iterator) : _hasNext = iterator.moveNext() {
    if (_hasNext) {
      _nextValue = iterator.current;
    }
  }

  final Iterator<T> iterator;
  T? _nextValue;
  bool _hasNext;

  @override
  bool hasNext() => _hasNext;

  @override
  T next() {
    if (!_hasNext) throw const NoSuchElementException();
    final e = _nextValue;
    _hasNext = iterator.moveNext();
    if (_hasNext) {
      _nextValue = iterator.current;
    }
    return e as T;
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
  final List<T> _list;

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
    _ensureHasLastReturnedElement();
    _list.removeAt(_lastRet);
    _cursor = _lastRet;
    _lastRet = -1;
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
    _ensureHasLastReturnedElement();
    _list.replaceRange(_lastRet, _lastRet + 1, [element]);
  }

  void _ensureHasLastReturnedElement() {
    if (_lastRet < 0) {
      throw const IndexOutOfBoundsException(
          "illegal cursor state -1. next() or previous() not called");
    }
  }
}
