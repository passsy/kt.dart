import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/iterator.dart";
import "package:kt_dart/src/util/hash.dart";

/// [KtList] implementation based on a dart [List]
class DartList<T> extends Object implements KtList<T> {
  /// Create an immutable [KtList] by copying the incoming [iterable] into a [List]
  DartList([Iterable<T> iterable = const []])
      : _list = List.unmodifiable(iterable),
        super();

  final List<T> _list;

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
    return elements.all(_list.contains);
  }

  @override
  T get(int index) {
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
  KtIterator<T> iterator() => InterOpKIterator<T>(_list.iterator);

  @override
  int lastIndexOf(T element) => _list.lastIndexOf(element);

  @override
  KtListIterator<T> listIterator([int index = 0]) {
    return InterOpKtListIterator(_list, index);
  }

  @override
  int get size => _list.length;

  @override
  KtList<T> subList(int fromIndex, int toIndex) {
    assert(() {
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
  int get hashCode => 1 + hashObjects(_list);

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

  @override
  String toString() {
    return joinToString(
      separator: ", ",
      prefix: "[",
      postfix: "]",
      transform: (it) =>
          identical(it, this) ? "(this Collection)" : it.toString(),
    );
  }
}
