import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/kt_iterator_mutable.dart';

class InterOpKIterator<T> implements KtIterator<T> {
  InterOpKIterator(this.iterator) {
    lastReturned = null;
    _hasNext = iterator.moveNext();
    nextValue = iterator.current;
  }

  final Iterator<T> iterator;
  T nextValue;
  T lastReturned;
  var _hasNext = false;

  @override
  bool hasNext() {
    return _hasNext;
  }

  @override
  T next() {
    if (!_hasNext) throw NoSuchElementException();
    final e = nextValue;
    _hasNext = iterator.moveNext();
    nextValue = iterator.current;
    lastReturned = e;
    return e;
  }
}

class InterOpKtListIterator<T>
    implements KtListIterator<T>, KtMutableListIterator<T> {
  InterOpKtListIterator(this.list, int index) : cursor = index {
    if (index < 0 || index > list.length) {
      throw IndexOutOfBoundsException("index: $index, size: $list.length");
    }
  }

  int cursor; // index of next element to return
  int lastRet = -1; // index of last element returned; -1 if no such
  List<T> list;

  @override
  bool hasNext() {
    return cursor != list.length;
  }

  @override
  T next() {
    final i = cursor;
    if (i >= list.length) throw NoSuchElementException();
    cursor = i + 1;
    return list[lastRet = i];
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
  bool hasPrevious() => cursor != 0;

  @override
  int nextIndex() => cursor + 1 > list.length ? list.length : cursor;

  @override
  T previous() {
    if (!hasPrevious()) throw NoSuchElementException();
    return list[--cursor];
  }

  @override
  int previousIndex() => cursor - 1;

  @override
  void add(T element) {
    final i = cursor;
    list.insert(i, element);
    lastRet = -1;
    cursor = i + 1;
  }

  @override
  void set(T element) {
    if (lastRet < 0)
      throw IndexOutOfBoundsException(
          "illegal cursor state -1. next() or previous() not called");
    list.replaceRange(lastRet, lastRet + 1, [element]);
  }
}
