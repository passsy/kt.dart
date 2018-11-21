import 'package:dart_kollection/dart_kollection.dart';

abstract class KListExtensionsMixin<T> implements KListExtension<T>, KList<T> {
  int get lastIndex => this.size - 1;

  @override
  T getOrElse(int index, T Function(int) defaultValue) {
    return (index >= 0 && index <= lastIndex) ? get(index) : defaultValue(index);
  }

  @override
  T getOrNull(int index) {
    return index >= 0 && index <= lastIndex ? get(index) : null;
  }

  @override
  KList<T> dropLast(int n) {
    var count = size - n;
    if (count < 0) {
      count = 0;
    }
    return take(count);
  }

  @override
  KList<T> dropLastWhile([bool Function(T) predicate]) {
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
}
