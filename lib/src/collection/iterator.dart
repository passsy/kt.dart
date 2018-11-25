import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/k_iterator_mutable.dart';

class DartIterator<T> implements KMutableIterator<T> {
  int cursor; // index of next element to return
  int lastRet = -1; // index of last element returned; -1 if no such
  List<T> list;

  DartIterator(this.list, int index) : this.cursor = index {
    if (index < 0 || index > list.length) {
      throw IndexOutOfBoundsException("index: $index, size: $list.length");
    }
  }

  @override
  bool hasNext() {
    return cursor != list.length;
  }

  @override
  T next() {
    int i = cursor;
    if (i >= list.length) throw new NoSuchElementException();
    cursor = i + 1;
    return list[lastRet = i];
  }

  @override
  void remove() {
    list.remove(lastRet);
  }
}

class DartListIterator<T> extends DartIterator<T> implements KListIterator<T>, KMutableListIterator<T> {
  DartListIterator(List<T> list, int index) : super(list, index);

  @override
  bool hasPrevious() => cursor != 0;

  @override
  int nextIndex() => cursor;

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
    list.replaceRange(lastRet, lastRet + 1, [element]);
  }
}
