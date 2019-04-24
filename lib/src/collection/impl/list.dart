import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/extension/collection_extension_mixin.dart';
import 'package:kt_dart/src/collection/extension/iterable_extension_mixin.dart';
import 'package:kt_dart/src/collection/extension/list_extension_mixin.dart';
import 'package:kt_dart/src/collection/impl/iterator.dart';
import 'package:kt_dart/src/util/hash.dart';

/// [KtList] implementation based on a dart [List]
class DartList<T> extends Object
    with
        KtIterableExtensionsMixin<T>,
        KtCollectionExtensionMixin<T>,
        KtListExtensionsMixin<T>
    implements KtList<T> {
  /// Create an immutable [KtList] by copying the incoming [iterable] into a [List]
  DartList([Iterable<T> iterable = const []])
      : _list = List.unmodifiable(iterable),
        super();

  final List<T> _list;
  int _hashCode;

  @override
  Iterable<T> get iter => _list;

  @override
  List<T> get list => _list;

  @override
  List<T> asList() => _list;

  @override
  bool contains(T element) => _list.contains(element);

  @override
  bool containsAll(KtCollection<T> elements) {
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
  KtIterator<T> iterator() => InterOpKIterator(_list.iterator);

  @override
  int lastIndexOf(T element) => _list.lastIndexOf(element);

  @override
  KtListIterator<T> listIterator([int index = 0]) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    return InterOpKtListIterator(_list, index);
  }

  @override
  int get size => _list.length;

  @override
  KtList<T> subList(int fromIndex, int toIndex) {
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
    return DartList(_list.sublist(fromIndex, toIndex));
  }

  @override
  int get hashCode => _hashCode ??= 1 + hashObjects(_list);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! KtList) return false;
    if (other.size != size) return false;
    if (other.hashCode != hashCode) return false;
    for (var i = 0; i != size; ++i) {
      if (other[i] != this[i]) return false;
    }
    return true;
  }
}
