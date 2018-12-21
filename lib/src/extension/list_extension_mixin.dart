import 'package:dart_kollection/dart_kollection.dart';

abstract class KListExtensionsMixin<T> implements KListExtension<T>, KList<T> {
  @override
  KList<T> dropLast(int n) {
    var count = size - n;
    if (count < 0) {
      count = 0;
    }
    return take(count);
  }

  @override
  KList<T> dropLastWhile(bool Function(T) predicate) {
    assert(predicate != null);
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
    if (index == null) throw ArgumentError("index can't be null");
    if (defaultValue == null)
      throw ArgumentError("defaultValue function can't be null");
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
    if (index == null) throw ArgumentError("index can't be null");
    if (defaultValue == null)
      throw ArgumentError("default value function can't be null");
    return (index >= 0 && index <= lastIndex)
        ? get(index)
        : defaultValue(index);
  }

  @override
  T getOrNull(int index) {
    if (index == null) throw ArgumentError("index can't be null");
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
  int get lastIndex => this.size - 1;

  @override
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

  @override
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

  @override
  KList<T> slice(KIterable<int> indices) {
    if (indices.count() == 0) {
      return emptyList<T>();
    }
    final list = mutableListOf<T>();
    for (final index in indices.iter) {
      list.add(get(index));
    }
    return list;
  }
}
