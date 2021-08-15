import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/iterator.dart";
import 'package:kt_dart/src/collection/impl/list.dart';
import 'package:kt_dart/src/util/arguments.dart';
import "package:kt_dart/src/util/hash.dart";

/// Caches the [_list] property in [ConstDartList]
///
/// Workaround because it's not possible to create a mutable property in the
/// const class. A final Map doesn't work because it would be immutable and
/// can't be used as cache
final _listExpando = Expando();

/// [KtList] implementation with a const constructor up to 10 elements
class ConstDartList<T> extends Object implements KtList<T> {
  const factory ConstDartList([
    T? arg0,
    T? arg1,
    T? arg2,
    T? arg3,
    T? arg4,
    T? arg5,
    T? arg6,
    T? arg7,
    T? arg8,
    T? arg9,
  ]) = ConstDartList._;

  const ConstDartList._([
    dynamic arg0 = defaultArgument,
    dynamic arg1 = defaultArgument,
    dynamic arg2 = defaultArgument,
    dynamic arg3 = defaultArgument,
    dynamic arg4 = defaultArgument,
    dynamic arg5 = defaultArgument,
    dynamic arg6 = defaultArgument,
    dynamic arg7 = defaultArgument,
    dynamic arg8 = defaultArgument,
    dynamic arg9 = defaultArgument,
  ])  : _arg0 = arg0,
        _arg1 = arg1,
        _arg2 = arg2,
        _arg3 = arg3,
        _arg4 = arg4,
        _arg5 = arg5,
        _arg6 = arg6,
        _arg7 = arg7,
        _arg8 = arg8,
        _arg9 = arg9;

  final dynamic _arg0;
  final dynamic _arg1;
  final dynamic _arg2;
  final dynamic _arg3;
  final dynamic _arg4;
  final dynamic _arg5;
  final dynamic _arg6;
  final dynamic _arg7;
  final dynamic _arg8;
  final dynamic _arg9;

  List<T> get _list {
    final cache = _listExpando[this];
    if (cache != null) {
      return cache as List<T>;
    }
    final value = List<T>.unmodifiable([
      if (_arg0 != defaultArgument) _arg0 as T,
      if (_arg1 != defaultArgument) _arg1 as T,
      if (_arg2 != defaultArgument) _arg2 as T,
      if (_arg3 != defaultArgument) _arg3 as T,
      if (_arg4 != defaultArgument) _arg4 as T,
      if (_arg5 != defaultArgument) _arg5 as T,
      if (_arg6 != defaultArgument) _arg6 as T,
      if (_arg7 != defaultArgument) _arg7 as T,
      if (_arg8 != defaultArgument) _arg8 as T,
      if (_arg9 != defaultArgument) _arg9 as T,
    ]);
    _listExpando[this] = value;
    return value;
  }

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
