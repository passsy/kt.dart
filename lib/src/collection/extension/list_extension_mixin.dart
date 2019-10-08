import "package:kt_dart/collection.dart";

extension KtListExtensions<T> on KtList<T> {
  /// Returns a list containing all elements except last [n] elements.
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

  /// Returns a list containing all elements except last elements that satisfy the given [predicate].
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

  /// Returns an element at the given [index] or throws an [IndexOutOfBoundsException] if the [index] is out of bounds of this list.
  @nonNull
  T elementAt(int index) => get(index);

  /// Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this list.
  @nonNull
  T elementAtOrElse(int index, T defaultValue(int index)) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      if (defaultValue == null) {
        throw ArgumentError("defaultValue function can't be null");
      }
      return true;
    }());
    return index >= 0 && index <= lastIndex ? get(index) : defaultValue(index);
  }

  /// Returns an element at the given [index] or `null` if the [index] is out of bounds of this collection.
  @nullable
  T elementAtOrNull(int index) => getOrNull(index);

  /// Returns first element.
  ///
  /// Use [predicate] to return the first element matching the given [predicate]
  ///
  /// @throws [NoSuchElementException] if the collection is empty.
  @nonNull
  T first([bool Function(T) predicate]) {
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

  /// Accumulates value starting with [initial] value and applying [operation] from right to left
  /// to each element with its index in the original list and current accumulator value.
  /// @param [operation] function that takes the index of an element, the element itself
  /// and current accumulator value, and calculates the next accumulator value.
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

  /// Returns an element at the given [index] or the result of calling the [defaultValue] function if the [index] is out of bounds of this list.
  @nonNull
  T getOrElse(int index, T Function(int) defaultValue) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      if (defaultValue == null) {
        throw ArgumentError("defaultValue function can't be null");
      }
      return true;
    }());
    return (index >= 0 && index <= lastIndex)
        ? get(index)
        : defaultValue(index);
  }

  /// Returns an element at the given [index] or `null` if the [index] is out of bounds of this list.
  @nullable
  T getOrNull(int index) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    return index >= 0 && index <= lastIndex ? get(index) : null;
  }

  /// Returns the last element matching the given [predicate].
  /// @throws [NoSuchElementException] if no such element is found.
  @nonNull
  T last([bool Function(T) predicate]) {
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

  /// Accumulates value starting with last element and applying [operation] from right to left to each element and current accumulator value.
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

  /// Accumulates value starting with last element and applying [operation] from right to left
  /// to each element with its index in the original list and current accumulator value.
  /// @param [operation] function that takes the index of an element, the element itself
  /// and current accumulator value, and calculates the next accumulator value.
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

  /// Returns the single element matching the given [predicate], or throws an exception if the list is empty or has more than one element.
  @nonNull
  T single([bool Function(T) predicate]) {
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
      T single;
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
      return single;
    }
  }

  /// Returns the single element matching the given [predicate], or `null` if element was not found or more than one element was found.
  @nullable
  T singleOrNull([bool Function(T) predicate]) {
    if (predicate == null) {
      if (size == 1) {
        return get(0);
      } else {
        return null;
      }
    } else {
      T single;
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

  /// Returns a list containing last [n] elements.
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

  /// Returns a list containing last elements satisfying the given [predicate].
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
