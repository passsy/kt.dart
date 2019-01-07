import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/iterator.dart';
import 'package:dart_kollection/src/extension/collection_extension_mixin.dart';
import 'package:dart_kollection/src/extension/collection_mutable_extension_mixin.dart';
import 'package:dart_kollection/src/extension/iterable_extension_mixin.dart';
import 'package:dart_kollection/src/extension/iterable_mutable_extension_mixin.dart';
import 'package:dart_kollection/src/extension/list_extension_mixin.dart';
import 'package:dart_kollection/src/extension/list_mutable_extension_mixin.dart';
import 'package:dart_kollection/src/util/hash.dart';

/**
 * [KList] based on a dart [List]
 */
class DartMutableList<T>
    with
        KIterableExtensionsMixin<T>,
        KCollectionExtensionMixin<T>,
        KMutableIterableExtensionsMixin<T>,
        KMutableCollectionExtensionMixin<T>,
        KListExtensionsMixin<T>,
        KMutableListExtensionsMixin<T>
    implements KMutableList<T> {
  DartMutableList([Iterable<T> iterable = const []])
      :
        // copy list to prevent external modification
        _list = List.from(iterable, growable: true),
        super();

  final List<T> _list;

  @override
  Iterable<T> get iter => _list;

  @override
  List<T> get list => _list;

  @override
  bool contains(T element) => _list.contains(element);

  @override
  bool containsAll(KCollection<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    return elements.all(_list.contains);
  }

  @override
  T get(int index) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    if (index < 0 || index >= size) {
      throw IndexOutOfBoundsException(
          "List doesn't contain element at index: $index, size: $size");
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
  KMutableIterator<T> iterator() => InterOpKListIterator(_list, 0);

  @override
  int lastIndexOf(T element) => _list.lastIndexOf(element);

  @override
  KMutableListIterator<T> listIterator([int index = 0]) {
    if (index == null) throw ArgumentError("index can't be null");
    return InterOpKListIterator(_list, index);
  }

  @override
  int get size => _list.length;

  @override
  bool add(T element) {
    _list.add(element);
    return true;
  }

  @override
  bool addAll(KIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    _list.addAll(elements.iter);
    return true;
  }

  @override
  bool addAllAt(int index, KCollection<T> elements) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    _list.insertAll(index, elements.iter);
    return true;
  }

  @override
  void addAt(int index, T element) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    _list.insert(index, element);
  }

  @override
  void clear() => _list.clear();

  @override
  bool remove(T element) => _list.remove(element);

  @override
  T removeAt(int index) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    if (index < 0 || index >= size) {
      throw IndexOutOfBoundsException("index: $index, size: $size");
    }
    return _list.removeAt(index);
  }

  @override
  T set(int index, T element) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    final old = _list[index];
    _list[index] = element;
    return old;
  }

  @override
  void operator []=(int index, T element) => set(index, element);

  @override
  bool removeAll(KIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    var changed = false;
    for (var value in elements.iter) {
      changed |= _list.remove(value);
    }
    return changed;
  }

  @override
  bool retainAll(KIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    _list.removeWhere((it) => !elements.contains(it));
    return true;
  }

  @override
  KMutableList<T> subList(int fromIndex, int toIndex) {
    assert(() {
      if (fromIndex == null) throw ArgumentError("fromIndex can't be null");
      if (toIndex == null) throw ArgumentError("toIndex can't be null");
      if (fromIndex > toIndex) {
        throw ArgumentError("fromIndex: $fromIndex > toIndex: $toIndex");
      }
      return true;
    }());
    if (fromIndex < 0 || toIndex > size) {
      throw IndexOutOfBoundsException(
          "fromIndex: $fromIndex, toIndex: $toIndex, size: $size");
    }
    return DartMutableList(_list.sublist(fromIndex, toIndex));
  }

  @override
  int get hashCode => 1 + hashObjects(_list);

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
