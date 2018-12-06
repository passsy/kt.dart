import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/iterator.dart';
import 'package:dart_kollection/src/extension/collection_extension_mixin.dart';
import 'package:dart_kollection/src/extension/iterable_extension_mixin.dart';
import 'package:dart_kollection/src/extension/list_extension_mixin.dart';
import 'package:dart_kollection/src/util/hash.dart';

/**
 * [KList] based on a dart [List]
 */
class DartList<T>
    with
        KIterableExtensionsMixin<T>,
        KCollectionExtensionMixin<T>,
        KListExtensionsMixin<T>
    implements KList<T> {
  final List<T> _list;
  int _hashCode;

  DartList([Iterable<T> iterable = const []])
      :
// copy list to prevent external modification
        _list = List.from(iterable, growable: false),
        super();

  @override
  Iterable<T> get iter => _list;

  @override
  List<T> get list => _list;

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
  KIterator<T> iterator() => InterOpKIterator(_list.iterator);

  @override
  int lastIndexOf(T element) => _list.lastIndexOf(element);

  @override
  KListIterator<T> listIterator([int index = 0]) {
    if (index == null) throw ArgumentError("index can't be null");
    return InterOpKListIterator(_list, index);
  }

  @override
  int get size => _list.length;

  @override
  KList<T> subList(int fromIndex, int toIndex) {
    if (fromIndex == null) throw ArgumentError("fromIndex can't be null");
    if (toIndex == null) throw ArgumentError("toIndex can't be null");
    if (fromIndex < 0 || toIndex > size) {
      throw IndexOutOfBoundsException(
          "fromIndex: $fromIndex, toIndex: $toIndex, size: $size");
    }
    if (fromIndex > toIndex) {
      throw ArgumentError("fromIndex: $fromIndex > toIndex: $toIndex");
    }
    return DartList(_list.sublist(fromIndex, toIndex));
  }

  @override
  int get hashCode {
    if (_hashCode == null) {
      _hashCode = 1 + hashObjects(_list);
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
