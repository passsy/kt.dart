import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/iterable.dart';
import 'package:dart_kollection/src/internal/collection_extension_mixin.dart';
import 'package:dart_kollection/src/internal/iterable_extension.dart';
import 'package:dart_kollection/src/internal/iterable_mutable_extension_mixin.dart';
import 'package:dart_kollection/src/internal/iterator.dart';
import 'package:dart_kollection/src/internal/list.dart';
import 'package:dart_kollection/src/internal/list_extension_mixin.dart';
import 'package:dart_kollection/src/internal/list_mutable_extension_mixin.dart';
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
        _list = List.from(iterable, growable: true),
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
  KMutableIterator<T> iterator() => DartIterator(_list, 0);

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
