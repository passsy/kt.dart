import 'dart:math' as math;

import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/comparisons.dart';
import 'package:dart_kollection/src/k_iterable.dart';

abstract class KIterableExtensionsMixin<T>
    implements KIterableExtension<T>, KIterable<T> {
  @override
  bool all([bool Function(T element) predicate]) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    if (this is KCollection && (this as KCollection).isEmpty()) return true;
    for (var element in iter) {
      if (!predicate(element)) {
        return false;
      }
    }
    return true;
  }

  @override
  bool any([bool Function(T element) predicate]) {
    if (predicate == null) {
      if (this is KCollection) return !(this as KCollection).isEmpty();
      return iterator().hasNext();
    }
    if (this is KCollection && (this as KCollection).isEmpty()) return false;
    for (var element in iter) {
      if (predicate(element)) return true;
    }
    return false;
  }

  @override
  KIterable<T> asIterable() => this;

  @override
  KMap<K, V> associate<K, V>(KPair<K, V> Function(T) transform) {
    return associateTo(linkedMapOf<K, V>(), transform);
  }

  @override
  KMap<K, T> associateBy<K>(K Function(T) keySelector) {
    return associateByTo(linkedMapOf<K, T>(), keySelector, null);
  }

  @override
  KMap<K, V> associateByTransform<K, V>(
      K Function(T) keySelector, V Function(T) valueTransform) {
    return associateByTo(linkedMapOf<K, V>(), keySelector, valueTransform);
  }

  @override
  M associateByTo<K, V, M extends KMutableMap<K, V>>(
      M destination, K Function(T) keySelector,
      [V Function(T) valueTransform]) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (keySelector == null) throw ArgumentError("keySelector can't be null");
      return true;
    }());
    for (var element in iter) {
      var key = keySelector(element);
      var value = valueTransform == null ? element : valueTransform(element);
      destination.put(key, value);
    }
    return destination;
  }

  @override
  M associateTo<K, V, M extends KMutableMap<K, V>>(
      M destination, KPair<K, V> Function(T) transform) {
    assert(() {
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    for (var element in iter) {
      var pair = transform(element);
      destination.put(pair.first, pair.second);
    }
    return destination;
  }

  @override
  KMap<T, V> associateWith<V>(V Function(T) valueSelector) {
    return associateWithTo(linkedMapOf<T, V>(), valueSelector);
  }

  // TODO add @override again
  M associateWithTo<V, M extends KMutableMap<T, V>>(
      M destination, V Function(T) valueSelector) {
    assert(() {
      if (valueSelector == null)
        throw ArgumentError("valueSelector can't be null");
      return true;
    }());
    for (var element in iter) {
      destination.put(element, valueSelector(element));
    }
    return destination;
  }

  @override
  double averageBy(num Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    num sum = 0.0;
    var count = 0;
    for (final element in iter) {
      sum += selector(element);
      ++count;
    }
    return count == 0 ? double.nan : sum / count;
  }

  @override
  KList<KList<T>> chunked(int size) {
    assert(() {
      if (size == null) throw ArgumentError("size can't be null");
      return true;
    }());
    return windowed(size, step: size, partialWindows: true);
  }

  @override
  KList<R> chunkedTransform<R>(int size, R Function(KList<T>) transform) {
    assert(() {
      if (size == null) throw ArgumentError("size can't be null");
      return true;
    }());
    return windowedTransform(size, transform, step: size, partialWindows: true);
  }

  @override
  bool contains(T element) {
    if (this is KCollection) return (this as KCollection).contains(element);
    return indexOf(element) >= 0;
  }

  @override
  int count([bool Function(T) predicate]) {
    if (predicate == null && this is KCollection) {
      return (this as KCollection).size;
    }
    var count = 0;
    Iterator it = iter.iterator;
    while (it.moveNext()) {
      if (predicate == null) {
        count++;
      } else {
        if (predicate(it.current)) {
          count++;
        }
      }
    }
    return count;
  }

  KList<T> distinct() => toMutableSet().toList();

  KList<T> distinctBy<K>(K Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    final set = hashSetOf<K>();
    final list = mutableListOf<T>();
    for (final element in iter) {
      final key = selector(element);
      if (set.add(key)) {
        list.add(element);
      }
    }
    return list;
  }

  @override
  KList<T> drop(int n) {
    assert(() {
      if (n == null) throw ArgumentError("n can't be null");
      return true;
    }());
    final list = mutableListOf<T>();
    var count = 0;
    for (final item in iter) {
      if (count++ >= n) {
        list.add(item);
      }
    }
    return list;
  }

  @override
  KList<T> dropWhile(bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    var yielding = false;
    var list = mutableListOf<T>();
    for (final item in iter) {
      if (yielding) {
        list.add(item);
      } else {
        if (!predicate(item)) {
          list.add(item);
          yielding = true;
        }
      }
    }
    return list;
  }

  @override
  T elementAt(int index) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());

    return elementAtOrElse(index, (int index) {
      throw IndexOutOfBoundsException(
          "Collection doesn't contain element at index $index.");
    });
  }

  @override
  T elementAtOrElse(int index, T Function(int) defaultValue) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      if (defaultValue == null)
        throw ArgumentError("defaultValue function can't be null");
      return true;
    }());
    if (index < 0) {
      return defaultValue(index);
    }
    final i = iterator();
    int count = 0;
    while (i.hasNext()) {
      final element = i.next();
      if (index == count++) {
        return element;
      }
    }
    return defaultValue(index);
  }

  @override
  T elementAtOrNull(int index) {
    assert(() {
      if (index == null) throw ArgumentError("index can't be null");
      return true;
    }());
    if (index < 0) {
      return null;
    }
    final i = iterator();
    int count = 0;
    while (i.hasNext()) {
      final element = i.next();
      if (index == count++) {
        return element;
      }
    }
    return null;
  }

  @override
  KList<T> filter(bool Function(T) predicate) {
    final list = filterTo(mutableListOf<T>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return list;
  }

  @override
  KList<T> filterIndexed(bool Function(int index, T) predicate) {
    final list = filterIndexedTo(mutableListOf<T>(), predicate);
    return list;
  }

  // TODO add @override again
  C filterIndexedTo<C extends KMutableCollection<T>>(
      C destination, bool Function(int index, T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    var i = 0;
    for (final element in iter) {
      if (predicate(i++, element)) {
        destination.add(element);
      }
    }
    return destination;
  }

  @override
  KList<R> filterIsInstance<R>() {
    final destination = mutableListOf<R>();
    for (final element in iter) {
      if (element is R) {
        destination.add(element);
      }
    }
    return destination;
  }

  @override
  KList<T> filterNot(bool Function(T) predicate) {
    final list = filterNotTo(mutableListOf<T>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return list;
  }

  @override
  KList<T> filterNotNull() {
    var list = filterNotNullTo(mutableListOf<T>());
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return list;
  }

  // TODO add @override again
  C filterNotNullTo<C extends KMutableCollection<T>>(C destination) {
    for (final element in iter) {
      if (element != null) {
        destination.add(element);
      }
    }
    return destination;
  }

  // TODO add @override again
  C filterNotTo<C extends KMutableCollection<T>>(
      C destination, bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      if (destination == null) throw ArgumentError("destination can't be null");
      return true;
    }());
    for (final element in iter) {
      if (!predicate(element)) {
        destination.add(element);
      }
    }
    return destination;
  }

  // TODO add @override again
  C filterTo<C extends KMutableCollection<T>>(
      C destination, bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      if (destination == null) throw ArgumentError("destination can't be null");
      return true;
    }());
    for (final element in iter) {
      if (predicate(element)) {
        destination.add(element);
      }
    }
    return destination;
  }

  @override
  T find(bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    return firstOrNull(predicate);
  }

  @override
  T findLast(bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    return lastOrNull(predicate);
  }

  @override
  T first([bool Function(T) predicate]) {
    if (predicate == null) {
      final i = iterator();
      if (!i.hasNext()) {
        throw NoSuchElementException("Collection is empty");
      }
      return i.next();
    } else {
      for (var element in iter) {
        if (predicate(element)) return element;
      }
      throw NoSuchElementException(
          "Collection contains no element matching the predicate.");
    }
  }

  @override
  T firstOrNull([bool Function(T) predicate]) {
    if (predicate == null) {
      if (this is KList) {
        var list = (this as KList);
        if (list.isEmpty()) {
          return null;
        } else {
          return list[0];
        }
      }
      final i = iterator();
      if (!i.hasNext()) {
        return null;
      }
      return i.next();
    } else {
      for (var element in iter) {
        if (predicate(element)) return element;
      }
      return null;
    }
  }

  @override
  KList<R> flatMap<R>(KIterable<R> Function(T) transform) {
    final list = flatMapTo(mutableListOf<R>(), transform);
    // making a temp variable here, it helps dart to get types right ¯\_(ツ)_/¯
    // TODO ping dort-lang/sdk team to check that bug
    return list;
  }

  @override
  C flatMapTo<R, C extends KMutableCollection<R>>(
      C destination, KIterable<R> Function(T) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    for (var element in iter) {
      final list = transform(element);
      destination.addAll(list);
    }
    return destination;
  }

  @override
  R fold<R>(R initial, R Function(R acc, T) operation) {
    assert(() {
      if (operation == null) throw ArgumentError("operation can't be null");
      return true;
    }());
    var accumulator = initial;
    for (final element in iter) {
      accumulator = operation(accumulator, element);
    }
    return accumulator;
  }

  @override
  R foldIndexed<R>(R initial, R Function(int index, R acc, T) operation) {
    assert(() {
      if (operation == null) throw ArgumentError("operation can't be null");
      return true;
    }());
    var index = 0;
    var accumulator = initial;
    for (final element in iter) {
      accumulator = operation(index++, accumulator, element);
    }
    return accumulator;
  }

  @override
  void forEach(void Function(T element) action) {
    assert(() {
      if (action == null) throw ArgumentError("action can't be null");
      return true;
    }());
    var i = iterator();
    while (i.hasNext()) {
      var element = i.next();
      action(element);
    }
  }

  @override
  void forEachIndexed(void Function(int index, T element) action) {
    assert(() {
      if (action == null) throw ArgumentError("action can't be null");
      return true;
    }());
    var index = 0;
    for (final item in iter) {
      action(index++, item);
    }
  }

  @override
  KMap<K, KList<T>> groupBy<K>(K Function(T) keySelector) {
    final groups = groupByTo(linkedMapOf<K, KMutableList<T>>(), keySelector);
    return groups;
  }

  @override
  KMap<K, KList<V>> groupByTransform<K, V>(
      K Function(T) keySelector, V Function(T) valueTransform) {
    final groups = groupByToTransform(
        linkedMapOf<K, KMutableList<V>>(), keySelector, valueTransform);
    return groups;
  }

  // TODO add @override again
  M groupByTo<K, M extends KMutableMap<K, KMutableList<T>>>(
      M destination, K Function(T) keySelector) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (keySelector == null) throw ArgumentError("keySelector can't be null");
      return true;
    }());
    for (final element in iter) {
      final key = keySelector(element);
      final list = destination.getOrPut(key, () => mutableListOf<T>());
      list.add(element);
    }
    return destination;
  }

  @override
  M groupByToTransform<K, V, M extends KMutableMap<K, KMutableList<V>>>(
      M destination, K Function(T) keySelector, V Function(T) valueTransform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (keySelector == null) throw ArgumentError("keySelector can't be null");
      if (valueTransform == null)
        throw ArgumentError("valueTransform can't be null");
      return true;
    }());
    for (final element in iter) {
      final key = keySelector(element);
      final list = destination.getOrPut(key, () => mutableListOf<V>());
      list.add(valueTransform(element));
    }
    return destination;
  }

  @override
  int indexOf(T element) {
    if (this is KList) return (this as KList).indexOf(element);
    var index = 0;
    for (var item in iter) {
      if (element == item) return index;
      index++;
    }
    return -1;
  }

  @override
  int indexOfFirst(bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    var index = 0;
    for (var item in iter) {
      if (predicate(item)) {
        return index;
      }
      index++;
    }
    return -1;
  }

  int indexOfLast(bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    var lastIndex = -1;
    var index = 0;
    for (var item in iter) {
      if (predicate(item)) {
        lastIndex = index;
      }
      index++;
    }
    return lastIndex;
  }

  KSet<T> intersect(KIterable<T> other) {
    final set = toMutableSet();
    set.retainAll(other);
    return set;
  }

  @override
  String joinToString(
      {String separator = ", ",
      String prefix = "",
      String postfix = "",
      int limit = -1,
      String truncated = "...",
      String Function(T) transform}) {
    var buffer = StringBuffer();
    buffer.write(prefix);
    var count = 0;
    for (var element in iter) {
      if (++count > 1) buffer.write(separator);
      if (limit >= 0 && count > limit) {
        break;
      } else {
        if (transform == null) {
          buffer.write(element);
        } else {
          buffer.write(transform(element));
        }
      }
    }
    if (limit >= 0 && count > limit) {
      buffer.write(truncated);
    }
    buffer.write(postfix);
    return buffer.toString();
  }

  @override
  T last([bool Function(T) predicate]) {
    if (predicate == null) {
      if (this is KList) return (this as KList).last();
      final i = iterator();
      if (!i.hasNext()) {
        throw NoSuchElementException("Collection is empty");
      }
      var last = i.next();
      while (i.hasNext()) {
        last = i.next();
      }
      return last;
    } else {
      T last = null;
      var found = false;
      for (final element in iter) {
        if (predicate(element)) {
          last = element;
          found = true;
        }
      }
      if (!found)
        throw NoSuchElementException(
            "Collection contains no element matching the predicate.");
      return last;
    }
  }

  int lastIndexOf(T element) {
    if (this is KList) return (this as KList).lastIndexOf(element);
    var lastIndex = -1;
    var index = 0;
    for (final item in iter) {
      if (element == item) {
        lastIndex = index;
      }
      index++;
    }
    return lastIndex;
  }

  @override
  T lastOrNull([bool Function(T) predicate]) {
    if (predicate == null) {
      if (this is KList) {
        var list = (this as KList);
        return list.isEmpty() ? null : list.get(list.lastIndex);
      } else {
        final i = iterator();
        if (!i.hasNext()) {
          return null;
        }
        var last = i.next();
        while (i.hasNext()) {
          last = i.next();
        }
        return last;
      }
    } else {
      T last = null;
      for (var element in iter) {
        if (predicate(element)) {
          last = element;
        }
      }
      return last;
    }
  }

  @override
  KList<R> map<R>(R Function(T) transform) {
    final KMutableList<R> list = mutableListOf<R>();
    var mapped = mapTo(list, transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return mapped;
  }

  @override
  KList<R> mapIndexed<R>(R Function(int index, T) transform) {
    var mapped = mapIndexedTo(mutableListOf<R>(), transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return mapped;
  }

  @override
  KList<R> mapIndexedNotNull<R>(R Function(int index, T) transform) {
    var mapped = mapIndexedNotNullTo(mutableListOf<R>(), transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return mapped;
  }

  @override
  C mapIndexedNotNullTo<R, C extends KMutableCollection<R>>(
      C destination, R Function(int index, T) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    var index = 0;
    for (final item in iter) {
      var element = transform(index++, item);
      if (element != null) {
        destination.add(element);
      }
    }
    return destination;
  }

  @override
  C mapIndexedTo<R, C extends KMutableCollection<R>>(
      C destination, R Function(int index, T) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    var index = 0;
    for (final item in iter) {
      destination.add(transform(index++, item));
    }
    return destination;
  }

  @override
  KList<R> mapNotNull<R>(R Function(T) transform) {
    var mapped = mapNotNullTo(mutableListOf<R>(), transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return mapped;
  }

  @override
  C mapNotNullTo<R, C extends KMutableCollection<R>>(
      C destination, R Function(T) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    for (final item in iter) {
      var result = transform(item);
      if (result != null) {
        destination.add(result);
      }
    }
    return destination;
  }

  @override
  C mapTo<R, C extends KMutableCollection<R>>(
      C destination, R Function(T) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    for (var item in iter) {
      destination.add(transform(item));
    }
    return destination;
  }

  @override
  num max() {
    if (this is! KIterable<num>) {
      throw ArgumentError(
          "sum is only supported for type KIterable<num>, not ${runtimeType}");
    }

    final i = iterator();
    if (!iterator().hasNext()) return null;
    num max = i.next() as num;
    if (max.isNaN) return max;
    while (i.hasNext()) {
      final num e = i.next() as num;
      if (e.isNaN) return e;
      if (max < e) {
        max = e;
      }
    }
    return max;
  }

  @override
  T maxBy<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    final i = iterator();
    if (!iterator().hasNext()) return null;
    T maxElement = i.next();
    R maxValue = selector(maxElement);
    while (i.hasNext()) {
      final e = i.next();
      final v = selector(e);
      if (maxValue.compareTo(v) < 0) {
        maxElement = e;
        maxValue = v;
      }
    }
    return maxElement;
  }

  @override
  T maxWith(Comparator<T> comparator) {
    assert(() {
      if (comparator == null) throw ArgumentError("comparator can't be null");
      return true;
    }());
    final i = iterator();
    if (!i.hasNext()) return null;
    var max = i.next();
    while (i.hasNext()) {
      final e = i.next();
      if (comparator(max, e) < 0) {
        max = e;
      }
    }
    return max;
  }

  @override
  num min() {
    if (this is! KIterable<num>) {
      throw ArgumentError(
          "sum is only supported for type KIterable<num>, not ${runtimeType}");
    }

    final i = iterator();
    if (!iterator().hasNext()) return null;
    num min = i.next() as num;
    if (min.isNaN) return min;
    while (i.hasNext()) {
      final num e = i.next() as num;
      if (e.isNaN) return e;
      if (min > e) {
        min = e;
      }
    }
    return min;
  }

  @override
  KList<T> minus(KIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    if (this is KCollection && (this as KCollection).isEmpty()) {
      return this.toList();
    }
    return filterNot((it) => elements.contains(it));
  }

  @override
  KList<T> operator -(KIterable<T> other) => minus(other);

  KList<T> minusElement(T element) {
    final result = mutableListOf<T>();
    var removed = false;
    filterTo(result, (it) {
      if (!removed && it == element) {
        removed = true;
        return false;
      } else {
        return true;
      }
    });
    return result;
  }

  @override
  T minBy<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    final i = iterator();
    if (!iterator().hasNext()) return null;
    T minElement = i.next();
    R minValue = selector(minElement);
    while (i.hasNext()) {
      final e = i.next();
      final v = selector(e);
      if (minValue.compareTo(v) > 0) {
        minElement = e;
        minValue = v;
      }
    }
    return minElement;
  }

  @override
  T minWith(Comparator<T> comparator) {
    assert(() {
      if (comparator == null) throw ArgumentError("comparator can't be null");
      return true;
    }());
    final i = iterator();
    if (!i.hasNext()) return null;
    var min = i.next();
    while (i.hasNext()) {
      final e = i.next();
      if (comparator(min, e) < 0) {
        min = e;
      }
    }
    return min;
  }

  @override
  bool none([bool Function(T) predicate]) {
    if (this is KCollection && (this as KCollection).isEmpty()) return true;
    if (predicate == null) return !iterator().hasNext();
    for (final element in iter) {
      if (predicate(element)) {
        return false;
      }
    }
    return true;
  }

  @override
  void onEach(void Function(T) action) {
    assert(() {
      if (action == null) throw ArgumentError("action can't be null");
      return true;
    }());
    for (final element in iter) {
      action(element);
    }
  }

  @override
  KPair<KList<T>, KList<T>> partition(bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    final first = mutableListOf<T>();
    final second = mutableListOf<T>();
    for (final element in iter) {
      if (predicate(element)) {
        first.add(element);
      } else {
        second.add(element);
      }
    }
    return KPair(first, second);
  }

  @override
  KList<T> plus(KIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    final result = mutableListOf<T>();
    result.addAll(this.asIterable());
    result.addAll(elements);
    return result;
  }

  KList<T> operator +(KIterable<T> elements) => plus(elements);

  @override
  KList<T> plusElement(T element) {
    final result = mutableListOf<T>();
    result.addAll(this.asIterable());
    result.add(element);
    return result;
  }

  @override
  S reduce<S>(S Function(S acc, T) operation) {
    assert(() {
      if (operation == null) throw ArgumentError("operation can't be null");
      return true;
    }());
    final i = iterator();
    if (!i.hasNext())
      throw UnsupportedError("Empty collection can't be reduced.");
    S accumulator = i.next() as S;
    while (i.hasNext()) {
      accumulator = operation(accumulator, i.next());
    }
    return accumulator;
  }

  @override
  S reduceIndexed<S>(S Function(int index, S acc, T) operation) {
    assert(() {
      if (operation == null) throw ArgumentError("operation can't be null");
      return true;
    }());
    final i = iterator();
    if (!i.hasNext())
      throw UnsupportedError("Empty collection can't be reduced.");
    var index = 1;
    S accumulator = i.next() as S;
    while (i.hasNext()) {
      accumulator = operation(index++, accumulator, i.next());
    }
    return accumulator;
  }

  /**
   * Returns an original collection containing all the non-`null` elements, throwing an [ArgumentError] if there are any `null` elements.
   */
  @override
  KIterable<T> requireNoNulls() {
    for (final element in iter) {
      if (element == null) {
        throw ArgumentError("null element found in $this.");
      }
    }
    return this;
  }

  @override
  KList<T> reversed() {
    if (this is KCollection && (this as KCollection).size <= 1) return toList();
    final list = toMutableList();
    list.reverse();
    return list;
  }

  @override
  T single([bool Function(T) predicate]) {
    if (predicate == null) {
      var i = iterator();
      if (!i.hasNext()) {
        throw NoSuchElementException("Collection is empty.");
      }
      final single = i.next();
      if (i.hasNext()) {
        throw ArgumentError("Collection has more than one element.");
      }
      return single;
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
      if (!found)
        throw NoSuchElementException(
            "Collection contains no element matching the predicate.");
      return single;
    }
  }

  T singleOrNull([bool Function(T) predicate]) {
    if (predicate == null) {
      final i = iterator();
      if (!i.hasNext()) return null;
      final single = i.next();
      if (i.hasNext()) {
        return null;
      }
      return single;
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
  KList<T> sorted() => sortedWith(naturalOrder());

  @override
  KList<T> sortedBy<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    return sortedWith(compareBy(selector));
  }

  @override
  KList<T> sortedByDescending<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    return sortedWith(compareByDescending(selector));
  }

  @override
  KList<T> sortedDescending() => sortedWith(reverseOrder());

  @override
  KList<T> sortedWith(Comparator<T> comparator) {
    assert(() {
      if (comparator == null) throw ArgumentError("comparator can't be null");
      return true;
    }());
    final mutableList = toMutableList();
    mutableList.list.sort(comparator);
    return mutableList;
  }

  @override
  KSet<T> subtract(KIterable<T> other) {
    assert(() {
      if (other == null) throw ArgumentError("other can't be null");
      return true;
    }());
    final set = toMutableSet();
    set.removeAll(other);
    return set;
  }

  @override
  num sum() {
    if (this is! KIterable<num>) {
      throw ArgumentError(
          "sum is only supported for type KIterable<num>, not ${runtimeType}");
    }

    num sum = 0;
    for (final element in iter) {
      sum += element as num;
    }
    return sum;
  }

  int sumBy(int Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    int sum = 0;
    for (final element in iter) {
      sum += selector(element);
    }
    return sum;
  }

  double sumByDouble(double Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    double sum = 0.0;
    for (final element in iter) {
      sum += selector(element);
    }
    return sum;
  }

  @override
  KList<T> take(int n) {
    assert(() {
      if (n == null) throw ArgumentError("n can't be null");
      return true;
    }());
    if (n < 0) {
      throw ArgumentError("Requested element count $n is less than zero.");
    }
    if (n == 0) return emptyList();
    if (this is KCollection) {
      final collection = this as KCollection;
      if (n >= collection.size) return toList();
      if (n == 1) return listOf([first()]);
    }
    var count = 0;
    final list = mutableListOf<T>();
    for (final item in iter) {
      if (count++ == n) {
        break;
      }
      list.add(item);
    }
    return list.toList();
  }

  C toCollection<C extends KMutableCollection<T>>(C destination) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      return true;
    }());
    for (final item in iter) {
      destination.add(item);
    }
    return destination;
  }

  @override
  KMutableSet<T> toHashSet() => hashSetOf(iter);

  @override
  KList<T> toList() => listOf(iter);

  @override
  KMutableList<T> toMutableList() => mutableListOf(iter);

  @override
  KMutableSet<T> toMutableSet() => linkedSetOf(iter);

  @override
  KSet<T> toSet() => linkedSetOf(iter);

  @override
  KSet<T> union(KIterable<T> other) {
    assert(() {
      if (other == null) throw ArgumentError("other can't be null");
      return true;
    }());
    final set = toMutableSet();
    set.addAll(other);
    return set;
  }

  @override
  KList<KList<T>> windowed(int size,
      {int step = 1, bool partialWindows = false}) {
    assert(() {
      if (size == null) throw ArgumentError("size can't be null");
      if (step == null) throw ArgumentError("step can't be null");
      if (partialWindows == null)
        throw ArgumentError("partialWindows can't be null");
      return true;
    }());
    final list = this.toList();
    final thisSize = list.size;
    final result = mutableListOf<KList<T>>();
    final window = _MovingSubList(list);
    var index = 0;
    while (index < thisSize) {
      window.move(index, math.min(thisSize, index + size));
      if (!partialWindows && window.size < size) break;
      result.add(window.snapshot());
      index += step;
    }
    return result;
  }

  @override
  KList<R> windowedTransform<R>(int size, R Function(KList<T>) transform,
      {int step = 1, bool partialWindows = false}) {
    assert(() {
      if (size == null) throw ArgumentError("size can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      if (step == null) throw ArgumentError("step can't be null");
      if (partialWindows == null)
        throw ArgumentError("partialWindows can't be null");
      return true;
    }());
    final list = this.toList();
    final thisSize = list.size;
    final result = mutableListOf<R>();
    final window = _MovingSubList(list);
    var index = 0;
    while (index < thisSize) {
      window.move(index, math.min(thisSize, index + size));
      if (!partialWindows && window.size < size) break;
      result.add(transform(window.snapshot()));
      index += step;
    }
    return result;
  }

  @override
  KList<KPair<T, R>> zip<R>(KIterable<R> other) =>
      zipTransform(other, (T a, R b) => KPair(a, b));

  @override
  KList<V> zipTransform<R, V>(
      KIterable<R> other, V Function(T a, R b) transform) {
    assert(() {
      if (other == null) throw ArgumentError("other can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    final first = iterator();
    final second = other.iterator();
    final list = mutableListOf<V>();
    while (first.hasNext() && second.hasNext()) {
      list.add(transform(first.next(), second.next()));
    }
    return list;
  }

  @override
  KList<KPair<T, T>> zipWithNext<R>() =>
      zipWithNextTransform((a, b) => KPair(a, b));

  @override
  KList<R> zipWithNextTransform<R>(R Function(T a, T b) transform) {
    assert(() {
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    final i = iterator();
    if (!i.hasNext()) {
      return emptyList();
    }
    final list = mutableListOf<R>();
    var current = i.next();
    while (i.hasNext()) {
      final next = i.next();
      list.add(transform(current, next));
      current = next;
    }
    return list;
  }
}

class _MovingSubList<T> {
  _MovingSubList(this.list);

  KList<T> list;
  var _fromIndex = 0;
  var _size = 0;

  void move(int fromIndex, int toIndex) {
    if (fromIndex < 0 || toIndex > list.size) {
      throw IndexOutOfBoundsException(
          "fromIndex: $fromIndex, toIndex: $toIndex, size: ${list.size}");
    }
    if (fromIndex > toIndex) {
      throw ArgumentError("fromIndex: $fromIndex > toIndex: $toIndex");
    }
    this._fromIndex = fromIndex;
    this._size = toIndex - fromIndex;
  }

  KList<T> snapshot() => list.subList(_fromIndex, _fromIndex + _size);

  int get size => _size;
}
