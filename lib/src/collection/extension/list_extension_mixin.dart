import 'package:kt_dart/collection.dart';

abstract class KtListExtensionsMixin<T>
    implements KtListExtension<T>, KtList<T> {
  @override
  KtList<T> dropLast(int n) {
    assert(() {
      if (n == null) throw ArgumentError("n can't be null");
      return true;
    }());
    var count = size - n;
    if (count < 0) {
      count = 0;
    }
    return take(count);
  }

  @override
  KtList<T> dropLastWhile(bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
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

  @override
  T elementAt(int index) => get(index);

  @override
  T elementAtOrElse(int index, T defaultValue(int index)) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      if (defaultValue == null)
        throw ArgumentError("defaultValue function can't be null");
      return true;
    }());
    return index >= 0 && index <= lastIndex ? get(index) : defaultValue(index);
  }

  @override
  T elementAtOrNull(int index) => getOrNull(index);

  @override
  T first([bool Function(T) predicate]) {
    if (predicate == null) {
      if (isEmpty()) throw NoSuchElementException("List is empty.");
      return get(0);
    } else {
      for (var element in iter) {
        if (predicate(element)) return element;
      }
      throw NoSuchElementException(
          "Collection contains no element matching the predicate.");
    }
  }

  @override
  R foldRight<R>(R initial, R Function(T, R acc) operation) {
    assert(() {
      if (operation == null) throw ArgumentError("operation can't be null");
      return true;
    }());
    if (isEmpty()) return initial;

    var accumulator = initial;
    final i = listIterator(size);
    while (i.hasPrevious()) {
      accumulator = operation(i.previous(), accumulator);
    }
    return accumulator;
  }

  @override
  R foldRightIndexed<R>(R initial, R Function(int index, T, R acc) operation) {
    assert(() {
      if (operation == null) throw ArgumentError("operation can't be null");
      return true;
    }());
    if (isEmpty()) return initial;

    var accumulator = initial;
    final i = listIterator(size);
    while (i.hasPrevious()) {
      accumulator = operation(i.previousIndex(), i.previous(), accumulator);
    }
    return accumulator;
  }

  @override
  T getOrElse(int index, T Function(int) defaultValue) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      if (defaultValue == null)
        throw ArgumentError("defaultValue function can't be null");
      return true;
    }());
    return (index >= 0 && index <= lastIndex)
        ? get(index)
        : defaultValue(index);
  }

  @override
  T getOrNull(int index) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    return index >= 0 && index <= lastIndex ? get(index) : null;
  }

  @override
  T last([bool Function(T) predicate]) {
    if (predicate == null) {
      if (isEmpty()) throw NoSuchElementException("List is empty.");
      return get(lastIndex);
    } else {
      final i = listIterator(size);
      if (!i.hasPrevious()) {
        throw NoSuchElementException("Collection is empty");
      }
      while (i.hasPrevious()) {
        final element = i.previous();
        if (predicate(element)) {
          return element;
        }
      }
      throw NoSuchElementException(
          "Collection contains no element matching the predicate.");
    }
  }

  @override
  int get lastIndex => size - 1;

  @override
  S reduceRight<S>(S Function(T, S acc) operation) {
    assert(() {
      if (operation == null) throw ArgumentError("operation can't be null");
      return true;
    }());
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

  @override
  S reduceRightIndexed<S>(S Function(int index, T, S acc) operation) {
    assert(() {
      if (operation == null) throw ArgumentError("operation can't be null");
      return true;
    }());
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

  @override
  T single([bool Function(T) predicate]) {
    if (predicate == null) {
      switch (size) {
        case 0:
          throw NoSuchElementException("List is empty");
        case 1:
          return get(0);
        default:
          throw ArgumentError("List has more than one element.");
      }
    } else {
      T single = null;
      var found = false;
      for (final element in iter) {
        if (predicate(element)) {
          if (found)
            throw ArgumentError(
                "Collection contains more than one matching element.");
          single = element;
          found = true;
        }
      }
      if (!found) {
        throw NoSuchElementException(
            "Collection contains no element matching the predicate.");
      }
      return single;
    }
  }

  @override
  T singleOrNull([bool Function(T) predicate]) {
    if (predicate == null) {
      if (size == 1) {
        return get(0);
      } else {
        return null;
      }
    } else {
      T single = null;
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

  @override
  KtList<T> slice(KtIterable<int> indices) {
    assert(() {
      if (indices == null) throw ArgumentError("indices can't be null");
      return true;
    }());
    if (indices.count() == 0) {
      return emptyList<T>();
    }
    final list = mutableListOf<T>();
    for (final index in indices.iter) {
      list.add(get(index));
    }
    return list;
  }

  @override
  KtList<T> takeLast(int n) {
    assert(() {
      if (n == null) throw ArgumentError("n can't be null");
      return true;
    }());
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

  @override
  KtList<T> takeLastWhile(bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
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
