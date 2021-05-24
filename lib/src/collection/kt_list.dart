import "package:kt_dart/collection.dart";
import 'package:kt_dart/src/collection/impl/iterator.dart';
import "package:kt_dart/src/collection/impl/list.dart";
import "package:kt_dart/src/collection/impl/list_empty.dart";
import "package:kt_dart/src/util/arguments.dart";
import 'package:kt_dart/src/util/hash.dart';

/// A generic ordered collection of elements. Methods in this interface support only read-only access to the list;
/// read/write access is supported through the [KtMutableList] interface.
/// @param [T] the type of elements contained in the list. The list is covariant on its element type.
abstract class KtList<T> implements KtCollection<T> {
  /// Returns an empty read-only list.
  const factory KtList.empty() = EmptyList<T>;

  /// Returns a new read-only list based on [elements].
  factory KtList.from([Iterable<T> elements = const []]) {
    if (elements.isEmpty) return EmptyList<T>();
    return DartList(elements);
  }

  /// Returns a new read-only list of given elements.
  ///
  /// `null` is a valid argument
  factory KtList.of(
      [T arg0,
      T arg1,
      T arg2,
      T arg3,
      T arg4,
      T arg5,
      T arg6,
      T arg7,
      T arg8,
      T arg9]) = KtList<T>._of;

  /// Implementation of KtList.of which creates a list of provided arguments
  /// where `T` might be `T` or `null`.
  factory KtList._of([
    Object? arg0 = defaultArgument,
    Object? arg1 = defaultArgument,
    Object? arg2 = defaultArgument,
    Object? arg3 = defaultArgument,
    Object? arg4 = defaultArgument,
    Object? arg5 = defaultArgument,
    Object? arg6 = defaultArgument,
    Object? arg7 = defaultArgument,
    Object? arg8 = defaultArgument,
    Object? arg9 = defaultArgument,
  ]) {
    return KtList.from([
      if (arg0 != defaultArgument) arg0 as T,
      if (arg1 != defaultArgument) arg1 as T,
      if (arg2 != defaultArgument) arg2 as T,
      if (arg3 != defaultArgument) arg3 as T,
      if (arg4 != defaultArgument) arg4 as T,
      if (arg5 != defaultArgument) arg5 as T,
      if (arg6 != defaultArgument) arg6 as T,
      if (arg7 != defaultArgument) arg7 as T,
      if (arg8 != defaultArgument) arg8 as T,
      if (arg9 != defaultArgument) arg9 as T,
    ]);
  }

  /// Deprecated, use [asList] or [iter] for loops
  @Deprecated("use asList() or iter instead")
  List<T> get list;

  // Query Operations
  @override
  int get size;

  /// Returns a read-only dart:core [List]
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  ///
  /// - Use [iter] to iterate over the elements of this [KtList] using a for-loop
  /// - Use [toList] to copy the list
  List<T> asList();

  @override
  bool isEmpty();

  @override
  bool contains(T element);

  @override
  KtIterator<T> iterator();

  // Bulk Operations
  @override
  bool containsAll(KtCollection<T> elements);

  // Positional Access Operations
  /// Returns the element at the specified index in the list or throw [IndexOutOfBoundsException]
  T get(int index);

  /// Returns the element at the specified index in the list or throw [IndexOutOfBoundsException]
  T operator [](int index);

  // Search Operations
  /// Returns the index of the first occurrence of the specified element in the list, or -1 if the specified
  /// element is not contained in the list.
  int indexOf(T element);

  /// Returns the index of the last occurrence of the specified element in the list, or -1 if the specified
  /// element is not contained in the list.
  int lastIndexOf(T element);

  // List Iterators
  /// Returns a list iterator over the elements in this list (in proper sequence), starting at the specified [index] or `0` by default.
  KtListIterator<T> listIterator([int index = 0]);

  // View
  /// Returns a view of the portion of this list between the specified [fromIndex] (inclusive) and [toIndex] (exclusive).
  /// The returned list is backed by this list, so non-structural changes in the returned list are reflected in this list, and vice-versa.
  ///
  /// Structural changes in the base list make the behavior of the view undefined.
  KtList<T> subList(int fromIndex, int toIndex);
}

extension KtListExtensions<T> on KtList<T> {
  /// Provides a view of this [KtList] as an list of [R] instances.
  ///
  /// If this [KtList] only contains instances of [R], all operations will work correctly.
  /// If any operation tries to access an element that is not an instance of [R], the access will throw a [TypeError] instead.
  KtList<R> cast<R>() => _CastKtList<T, R>(this);

  /// Returns a read-only dart:core [List]
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  List<T> get dart => asList();

  /// Returns a list containing all elements except last [n] elements.
  KtList<T> dropLast(int n) {
    var count = size - n;
    if (count < 0) {
      count = 0;
    }
    return take(count);
  }

  /// Returns a list containing all elements except last elements that satisfy the given [predicate].
  KtList<T> dropLastWhile(bool Function(T) predicate) {
    if (!isEmpty()) {
      final i = listIterator(size);
      while (i.hasPrevious()) {
        if (!predicate(i.previous())) {
          return take(i.nextIndex() + 1);
        }
      }
    }
    return emptyList<T>();
  }

  /// Returns an element at the given [index] or throws an [IndexOutOfBoundsException] if the [index] is out of bounds of this list.
  T elementAt(int index) => get(index);

  /// Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this list.
  T elementAtOrElse(int index, T Function(int index) defaultValue) {
    return index >= 0 && index <= lastIndex ? get(index) : defaultValue(index);
  }

  /// Returns an element at the given [index] or `null` if the [index] is out of bounds of this collection.
  T? elementAtOrNull(int index) => getOrNull(index);

  /// Returns first element.
  ///
  /// Use [predicate] to return the first element matching the given [predicate]
  ///
  /// @throws [NoSuchElementException] if the collection is empty.
  T first([bool Function(T)? predicate]) {
    if (predicate == null) {
      if (isEmpty()) throw const NoSuchElementException("List is empty.");
      return get(0);
    } else {
      for (final element in iter) {
        if (predicate(element)) return element;
      }
      throw const NoSuchElementException(
          "Collection contains no element matching the predicate.");
    }
  }

  /// Accumulates value starting with [initial] value and applying [operation] from right to left to each element and current accumulator value.
  R foldRight<R>(R initial, R Function(T, R acc) operation) {
    if (isEmpty()) return initial;

    var accumulator = initial;
    final i = listIterator(size);
    while (i.hasPrevious()) {
      accumulator = operation(i.previous(), accumulator);
    }
    return accumulator;
  }

  /// Accumulates value starting with [initial] value and applying [operation] from right to left
  /// to each element with its index in the original list and current accumulator value.
  /// @param [operation] function that takes the index of an element, the element itself
  /// and current accumulator value, and calculates the next accumulator value.
  R foldRightIndexed<R>(R initial, R Function(int index, T, R acc) operation) {
    if (isEmpty()) return initial;

    var accumulator = initial;
    final i = listIterator(size);
    while (i.hasPrevious()) {
      accumulator = operation(i.previousIndex(), i.previous(), accumulator);
    }
    return accumulator;
  }

  /// Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this list.
  T getOrElse(int index, T Function(int) defaultValue) {
    return (index >= 0 && index <= lastIndex)
        ? get(index)
        : defaultValue(index);
  }

  /// Returns an element at the given [index] or `null` if the [index] is out of bounds of this list.
  T? getOrNull(int index) {
    return index >= 0 && index <= lastIndex ? get(index) : null;
  }

  /// Returns the last element matching the given [predicate].
  /// @throws [NoSuchElementException] if no such element is found.
  T last([bool Function(T)? predicate]) {
    if (predicate == null) {
      if (isEmpty()) throw const NoSuchElementException("List is empty.");
      return get(lastIndex);
    } else {
      final i = listIterator(size);
      if (!i.hasPrevious()) {
        throw const NoSuchElementException("Collection is empty");
      }
      while (i.hasPrevious()) {
        final element = i.previous();
        if (predicate(element)) {
          return element;
        }
      }
      throw const NoSuchElementException(
          "Collection contains no element matching the predicate.");
    }
  }

  /// Returns the index of the last item in the list or -1 if the list is empty.
  int get lastIndex => size - 1;

  /// Accumulates value starting with last element and applying [operation] from right to left to each element and current accumulator value.
  S reduceRight<S>(S Function(T, S acc) operation) {
    final i = listIterator(size);
    if (!i.hasPrevious()) {
      throw UnimplementedError("Empty list can't be reduced.");
    }
    var accumulator = i.previous() as S;
    while (i.hasPrevious()) {
      accumulator = operation(i.previous(), accumulator);
    }
    return accumulator;
  }

  /// Accumulates value starting with last element and applying [operation] from right to left
  /// to each element with its index in the original list and current accumulator value.
  /// @param [operation] function that takes the index of an element, the element itself
  /// and current accumulator value, and calculates the next accumulator value.
  S reduceRightIndexed<S>(S Function(int index, T, S acc) operation) {
    final i = listIterator(size);
    if (!i.hasPrevious()) {
      throw UnimplementedError("Empty list can't be reduced.");
    }
    var accumulator = i.previous() as S;
    while (i.hasPrevious()) {
      accumulator = operation(i.previousIndex(), i.previous(), accumulator);
    }
    return accumulator;
  }

  /// Returns the single element matching the given [predicate], or throws an exception if the list is empty or has more than one element.
  T single([bool Function(T)? predicate]) {
    if (predicate == null) {
      switch (size) {
        case 0:
          throw const NoSuchElementException("List is empty");
        case 1:
          return get(0);
        default:
          throw ArgumentError("List has more than one element.");
      }
    } else {
      T? single;
      var found = false;
      for (final element in iter) {
        if (predicate(element)) {
          if (found) {
            throw ArgumentError(
                "Collection contains more than one matching element.");
          }
          single = element;
          found = true;
        }
      }
      if (!found) {
        throw const NoSuchElementException(
            "Collection contains no element matching the predicate.");
      }
      return single!;
    }
  }

  /// Returns the single element matching the given [predicate], or `null` if element was not found or more than one element was found.
  T? singleOrNull([bool Function(T)? predicate]) {
    if (predicate == null) {
      if (size == 1) {
        return get(0);
      } else {
        return null;
      }
    } else {
      T? single;
      var found = false;
      for (final element in iter) {
        if (predicate(element)) {
          if (found) return null;
          single = element;
          found = true;
        }
      }
      if (!found) return null;
      return single;
    }
  }

  /// Returns a list containing elements at specified [indices].
  KtList<T> slice(KtIterable<int> indices) {
    if (indices.count() == 0) {
      return emptyList<T>();
    }
    final list = mutableListOf<T>();
    for (final index in indices.iter) {
      list.add(get(index));
    }
    return list;
  }

  /// Returns a list containing last [n] elements.
  KtList<T> takeLast(int n) {
    if (n < 0) {
      throw ArgumentError("Requested element count $n is less than zero.");
    }
    if (n == 0) return emptyList();
    if (n >= size) return toList();
    if (n == 1) return listFrom([last()]);
    final list = mutableListOf<T>();
    for (var i = size - n; i < size; i++) {
      list.add(get(i));
    }
    return list;
  }

  /// Returns a list containing last elements satisfying the given [predicate].
  KtList<T> takeLastWhile(bool Function(T) predicate) {
    if (isEmpty()) return emptyList();
    final iterator = listIterator(size);
    while (iterator.hasPrevious()) {
      if (!predicate(iterator.previous())) {
        iterator.next();
        final expectedSize = size - iterator.nextIndex();
        if (expectedSize == 0) return emptyList();
        final list = mutableListOf<T>();
        while (iterator.hasNext()) {
          list.add(iterator.next());
        }
        return list;
      }
    }
    return toList();
  }
}

extension NullableKtListExtensions<T> on KtList<T>? {
  /// Returns this [KtList] if it's not `null` and the empty list otherwise.
  KtList<T> orEmpty() => this ?? KtList<T>.empty();
}

extension RequireNoNullsKtListExtension<T> on KtList<T?> {
  /// Returns an original collection containing all the non-`null` elements, throwing an [ArgumentError] if there are any `null` elements.
  KtList<T> requireNoNulls() {
    for (final element in iter) {
      if (element == null) {
        throw ArgumentError("null element found in $this.");
      }
    }
    return cast<T>();
  }
}

/// View on an [KtList] casting each item when accessed
class _CastKtList<Source, T> implements KtList<T> {
  _CastKtList(KtList<Source> list) : _list = list;

  final KtList<Source> _list;
  int? _hashCode;

  @override
  Iterable<T> get iter => _list.asList().cast();

  @override
  KtIterator<T> iterator() {
    return _CastKtIterator(_list.asList().iterator);
  }

  @override
  T operator [](int index) {
    return _list[index] as T;
  }

  @override
  List<T> asList() {
    return _list.dart.cast();
  }

  @override
  bool contains(T element) {
    return _list.contains(element as Source);
  }

  @override
  bool containsAll(KtCollection<T> elements) {
    return _list.containsAll(elements.map((it) => it as Source));
  }

  @override
  T get(int index) {
    return _list.get(index) as T;
  }

  @override
  int indexOf(T element) {
    return _list.indexOf(element as Source);
  }

  @override
  bool isEmpty() {
    return _list.isEmpty();
  }

  @override
  int lastIndexOf(T element) {
    return _list.lastIndexOf(element as Source);
  }

  @Deprecated("use asList() or iter instead")
  @override
  List<T> get list => _list.list.cast();

  @override
  KtListIterator<T> listIterator([int index = 0]) {
    return InterOpKtListIterator(_list.asList().cast(), index);
  }

  @override
  int get size => _list.size;

  @override
  KtList<T> subList(int fromIndex, int toIndex) {
    return _list.subList(fromIndex, toIndex).map((it) => it as T);
  }

  @override
  int get hashCode => _hashCode ??= 1 + hashObjects(_list.asList());

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

class _CastKtIterator<Source, T> implements KtIterator<T> {
  _CastKtIterator(this.iterator) : _hasNext = iterator.moveNext() {
    if (_hasNext) {
      _nextValue = iterator.current as T;
    }
  }

  final Iterator<Source> iterator;
  T? _nextValue;
  bool _hasNext;

  @override
  bool hasNext() => _hasNext;

  @override
  T next() {
    if (!_hasNext) throw const NoSuchElementException();
    final e = _nextValue;
    _hasNext = iterator.moveNext();
    if (_hasNext) {
      _nextValue = iterator.current as T;
    }
    return e as T;
  }
}
