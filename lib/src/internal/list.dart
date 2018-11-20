import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/iterable.dart';
import 'package:dart_kollection/src/internal/collection_extension.dart';
import 'package:dart_kollection/src/internal/iterable_extension.dart';
import 'package:dart_kollection/src/internal/iterator.dart';
import 'package:dart_kollection/src/internal/list_extension.dart';
import 'package:dart_kollection/src/util/hash.dart';

/**
 * [KList] based on a dart [List]
 */
class DartList<T>
    with KListExtensionsMixin<T>, KCollectionExtensionMixin<T>, KIterableExtensionsMixin<T>
    implements KList<T> {
  final List<T> _list;
  int _hashCode;

  DartList([Iterable<T> iterable = const []])
      :
// copy list to prevent external modification
        _list = List.from(iterable, growable: false),
        super();

  Iterable<T> get iter => DartIterable<T>(this);

  @override
  bool contains(T element) => _list.contains(element);

  @override
  bool containsAll(KCollection<T> elements) {
    return elements.any((it) => !_list.contains(it));
  }

  @override
  T get(int index) {
    if (index == null) throw ArgumentError("index can't be null");
    if (index < 0 || index >= size) {
      throw IndexOutOfBoundsException("index: $index, size: $size");
    }
    return _list[index];
  }

  @override
  T operator [](int index) => get(index);

  @override
  int indexOf(T element) => _list.indexOf(element);

  @override
  bool isEmpty() => _list.isEmpty;

  @override
  KIterator<T> iterator() => DartIterator(_list, 0);

  @override
  int lastIndexOf(T element) => _list.lastIndexOf(element);

  @override
  KListIterator<T> listIterator([int index = 0]) {
    if (index == null) throw ArgumentError("index can't be null");
    return DartListIterator(_list, index);
  }

  @override
  int get size => _list.length;

  @override
  KList<T> subList(int fromIndex, int toIndex) {
    if (fromIndex == null) throw ArgumentError("fromIndex can't be null");
    if (toIndex == null) throw ArgumentError("toIndex can't be null");
    if (fromIndex < 0 || toIndex > size) {
      throw IndexOutOfBoundsException("fromIndex: $fromIndex, toIndex: $toIndex, size: $size");
    }
    if (fromIndex > toIndex) {
      throw ArgumentError("fromIndex: $fromIndex > toIndex: $toIndex");
    }
    return DartList(_list.sublist(fromIndex, toIndex));
  }

  @override
  int get hashCode {
    if (_hashCode == null) {
      _hashCode = hashObjects(_list);
    }
    return _hashCode;
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! KList) return false;
    if (other.size != size) return false;
    if (other.hashCode != hashCode) return false;
    for (var i = 0; i != size; ++i) {
      if (other[i] != this[i]) return false;
    }
    return true;
  }
}

// TODO replace with _DartToKIterator?
class _DartListIterator<T> implements KIterator<T> {
  int cursor; // index of next element to return
  int lastRet = -1; // index of last element returned; -1 if no such
  List<T> list;

  _DartListIterator(this.list, int index) : this.cursor = index {
    if (index < 0 || index >= list.length) {
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
}

class _DartListListIterator<T> extends _DartListIterator<T> implements KListIterator<T> {
  _DartListListIterator(List<T> list, int index) : super(list, index);

  @override
  bool hasPrevious() => cursor != 0;

  @override
  int nextIndex() => cursor;

  @override
  T previous() {
    int i = cursor - 1;
    if (i < 0) throw NoSuchElementException();
    cursor = i;
    return list[lastRet = i];
  }

  @override
  int previousIndex() => cursor - 1;
}
