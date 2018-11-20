import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/iterable.dart';
import 'package:dart_kollection/src/internal/collection_extension.dart';
import 'package:dart_kollection/src/internal/iterable_extension.dart';
import 'package:dart_kollection/src/internal/iterable_mutable_extension.dart';
import 'package:dart_kollection/src/internal/iterator.dart';
import 'package:dart_kollection/src/internal/list.dart';
import 'package:dart_kollection/src/internal/list_extension.dart';
import 'package:dart_kollection/src/internal/list_mutable_extension.dart';
import 'package:dart_kollection/src/util/hash.dart';

/**
 * [KList] based on a dart [List]
 */
class DartMutableList<T>
    with
        KMutableListExtensionsMixin<T>,
        KListExtensionsMixin<T>,
        KMutableIterableExtensionsMixin<T>,
        KCollectionExtensionMixin<T>,
        KIterableExtensionsMixin<T>
    implements KMutableList<T> {
  final List<T> _list;
  int _hashCode;

  DartMutableList([Iterable<T> iterable = const []])
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
  KMutableIterator<T> iterator() => _DartListIterator(_list, 0);

  @override
  int lastIndexOf(T element) => _list.lastIndexOf(element);

  @override
  KListIterator<T> listIterator([int index = 0]) {
    if (index == null) throw ArgumentError("index can't be null");
    return _DartListListIterator(_list, index);
  }

  @override
  int get size => _list.length;

  @override
  bool add(T element) {
    _list.add(element);
    return true;
  }

  @override
  bool addAll(KCollection<T> elements) {
    _list.addAll(elements.iter);
    return true;
  }

  @override
  bool addAllAt(int index, KCollection<T> elements) {
    _list.insertAll(index, elements.iter);
    return true;
  }

  @override
  void addAt(int index, T element) {
    _list.insert(index, element);
  }

  @override
  void clear() => _list.clear();

  @override
  bool remove(T element) => _list.remove(element);

  @override
  T removeAt(int index) => _list.removeAt(index);

  @override
  T set(int index, T element) {
    final old = _list[index];
    _list.insert(index, element);
    return old;
  }

  @override
  bool removeAll(KCollection<T> elements) {
    var changed = false;
    for (var value in elements.iter) {
      changed |= _list.remove(value);
    }
    return changed;
  }

  @override
  bool retainAll(KCollection<T> elements) {
    _list.removeWhere((it) => !elements.contains(it));
  }

  @override
  KList<T> subList(int fromIndex, int toIndex) {
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

class _DartListIterator<T> implements KMutableIterator<T> {
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

  @override
  void remove() {
    list.remove(lastRet);
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
