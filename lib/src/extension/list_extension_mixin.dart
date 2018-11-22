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
    return index >= 0 && index <= lastIndex ? get(index) : defaultValue(index);
  }

  @override
  T elementAtOrNull(int index) => getOrNull(index);

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
    return (index >= 0 && index <= lastIndex) ? get(index) : defaultValue(index);
  }

  @override
  T getOrNull(int index) {
    return index >= 0 && index <= lastIndex ? get(index) : null;
  }

  @override
  int get lastIndex => this.size - 1;

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
