import 'dart:math' as math;

import 'package:kotlin_dart/collection.dart';
import 'package:kotlin_dart/src/collection/comparisons.dart';
import 'package:kotlin_dart/src/util/errors.dart';

abstract class KtIterableExtensionsMixin<T>
    implements KtIterableExtension<T>, KtIterable<T> {
  @override
  bool all([bool Function(T element) predicate]) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    if (this is KtCollection && (this as KtCollection).isEmpty()) return true;
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
      if (this is KtCollection) return !(this as KtCollection).isEmpty();
      return iterator().hasNext();
    }
    if (this is KtCollection && (this as KtCollection).isEmpty()) return false;
    for (var element in iter) {
      if (predicate(element)) return true;
    }
    return false;
  }

  @override
  KtIterable<T> asIterable() => this;

  @override
  KtMap<K, V> associate<K, V>(KPair<K, V> Function(T) transform) {
    return associateTo(linkedMapFrom<K, V>(), transform);
  }

  @override
  KtMap<K, T> associateBy<K>(K Function(T) keySelector) {
    return associateByTo<K, T, KtMutableMap<K, T>>(
        linkedMapFrom<K, T>(), keySelector, null);
  }

  @override
  KtMap<K, V> associateByTransform<K, V>(
      K Function(T) keySelector, V Function(T) valueTransform) {
    return associateByTo(linkedMapFrom<K, V>(), keySelector, valueTransform);
  }

  @override
  M associateByTo<K, V, M extends KtMutableMap<K, V>>(
      M destination, K Function(T) keySelector,
      [V Function(T) valueTransform]) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (keySelector == null) throw ArgumentError("keySelector can't be null");
      return true;
    }());
    for (var element in iter) {
      final key = keySelector(element);
      final V value =
          valueTransform == null ? element : valueTransform(element);
      destination.put(key, value);
    }
    return destination;
  }

  @override
  M associateTo<K, V, M extends KtMutableMap<K, V>>(
      M destination, KPair<K, V> Function(T) transform) {
    assert(() {
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    for (var element in iter) {
      final pair = transform(element);
      destination.put(pair.first, pair.second);
    }
    return destination;
  }

  @override
  KtMap<T, V> associateWith<V>(V Function(T) valueSelector) {
    final associated = associateWithTo(linkedMapFrom<T, V>(), valueSelector);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return associated;
  }

  @override
  M associateWithTo<V, M extends KtMutableMap<dynamic, dynamic>>(
      M destination, V Function(T) valueSelector) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (valueSelector == null)
        throw ArgumentError("valueSelector can't be null");
      if (destination is! KtMutableMap<T, V> && mutableMapFrom<T, V>() is! M)
        throw ArgumentError(
            "associateWithTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$T, $V>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) items aren't subtype of "
            "$runtimeType items. Items can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
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
  KtList<KtList<T>> chunked(int size) {
    assert(() {
      if (size == null) throw ArgumentError("size can't be null");
      return true;
    }());
    return windowed(size, step: size, partialWindows: true);
  }

  @override
  KtList<R> chunkedTransform<R>(int size, R Function(KtList<T>) transform) {
    assert(() {
      if (size == null) throw ArgumentError("size can't be null");
      return true;
    }());
    return windowedTransform(size, transform, step: size, partialWindows: true);
  }

  @override
  bool contains(T element) {
    if (this is KtCollection) return (this as KtCollection).contains(element);
    return indexOf(element) >= 0;
  }

  @override
  int count([bool Function(T) predicate]) {
    if (predicate == null && this is KtCollection) {
      return (this as KtCollection).size;
    }
    var count = 0;
    final Iterator<T> i = iter.iterator;
    while (i.moveNext()) {
      if (predicate == null) {
        count++;
      } else {
        if (predicate(i.current)) {
          count++;
        }
      }
    }
    return count;
  }

  @override
  KtList<T> distinct() => toMutableSet().toList();

  @override
  KtList<T> distinctBy<K>(K Function(T) selector) {
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
  KtList<T> drop(int n) {
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
  KtList<T> dropWhile(bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    var yielding = false;
    final list = mutableListOf<T>();
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
          "Collection doesn't contain element at index: $index.");
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
  KtList<T> filter(bool Function(T) predicate) {
    final filtered = filterTo(mutableListOf<T>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return filtered;
  }

  @override
  KtList<T> filterIndexed(bool Function(int index, T) predicate) {
    final filtered = filterIndexedTo(mutableListOf<T>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return filtered;
  }

  @override
  C filterIndexedTo<C extends KtMutableCollection<dynamic>>(
      C destination, bool Function(int index, T) predicate) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (predicate == null) throw ArgumentError("predicate can't be null");
      if (destination is! KtMutableCollection<T> && mutableListOf<T>() is! C)
        throw ArgumentError(
            "filterIndexedTo destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
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
  KtList<R> filterIsInstance<R>() {
    final destination = mutableListOf<R>();
    for (final element in iter) {
      if (element is R) {
        destination.add(element);
      }
    }
    return destination;
  }

  @override
  KtList<T> filterNot(bool Function(T) predicate) {
    final list = filterNotTo(mutableListOf<T>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return list;
  }

  @override
  KtList<T> filterNotNull() {
    final list = filterNotNullTo(mutableListOf<T>());
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return list;
  }

  @override
  C filterNotNullTo<C extends KtMutableCollection<dynamic>>(C destination) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (destination is! KtMutableCollection<T> && mutableListOf<T>() is! C)
        throw ArgumentError(
            "filterNotNullTo destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      return true;
    }());
    for (final element in iter) {
      if (element != null) {
        destination.add(element);
      }
    }
    return destination;
  }

  @override
  C filterNotTo<C extends KtMutableCollection<dynamic>>(
      C destination, bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      if (destination == null) throw ArgumentError("destination can't be null");
      if (destination is! KtMutableCollection<T> && mutableListOf<T>() is! C)
        throw ArgumentError("filterNotTo destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      return true;
    }());
    for (final element in iter) {
      if (!predicate(element)) {
        destination.add(element);
      }
    }
    return destination;
  }

  @override
  C filterTo<C extends KtMutableCollection<dynamic>>(
      C destination, bool Function(T) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      if (destination == null) throw ArgumentError("destination can't be null");
      if (destination is! KtMutableCollection<T> && mutableListOf<T>() is! C)
        throw ArgumentError("filterTo destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
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
      if (this is KtList) {
        final list = this as KtList<T>;
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
  KtList<R> flatMap<R>(KtIterable<R> Function(T) transform) {
    final list = flatMapTo(mutableListOf<R>(), transform);
    // making a temp variable here, it helps dart to get types right ¯\_(ツ)_/¯
    // TODO ping dort-lang/sdk team to check that bug
    return list;
  }

  @override
  C flatMapTo<R, C extends KtMutableCollection<R>>(
      C destination, KtIterable<R> Function(T) transform) {
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
    final i = iterator();
    while (i.hasNext()) {
      final element = i.next();
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
  KtMap<K, KtList<T>> groupBy<K>(K Function(T) keySelector) {
    final groups = groupByTo(linkedMapFrom<K, KtMutableList<T>>(), keySelector);
    return groups;
  }

  @override
  KtMap<K, KtList<V>> groupByTransform<K, V>(
      K Function(T) keySelector, V Function(T) valueTransform) {
    final groups = groupByToTransform(
        linkedMapFrom<K, KtMutableList<V>>(), keySelector, valueTransform);
    return groups;
  }

  @override
  M groupByTo<K, M extends KtMutableMap<K, KtMutableList<dynamic>>>(
      M destination, K Function(T) keySelector) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (keySelector == null) throw ArgumentError("keySelector can't be null");
      if (destination is! KtMutableMap<K, KtMutableList<T>> &&
          mutableMapFrom<K, KtMutableList<T>>() is! M)
        throw ArgumentError("groupByTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<K, KtMutableList<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
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
  M groupByToTransform<K, V, M extends KtMutableMap<K, KtMutableList<V>>>(
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
    if (this is KtList) return (this as KtList).indexOf(element);
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

  @override
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

  @override
  KtSet<T> intersect(KtIterable<T> other) {
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
    final buffer = StringBuffer();
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
      if (this is KtList) return (this as KtList<T>).last();
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

  @override
  int lastIndexOf(T element) {
    if (this is KtList) return (this as KtList).lastIndexOf(element);
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
      if (this is KtList) {
        final list = this as KtList<T>;
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
  KtList<R> map<R>(R Function(T) transform) {
    final KtMutableList<R> list = mutableListOf<R>();
    final mapped = mapTo(list, transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return mapped;
  }

  @override
  KtList<R> mapIndexed<R>(R Function(int index, T) transform) {
    final mapped = mapIndexedTo(mutableListOf<R>(), transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return mapped;
  }

  @override
  KtList<R> mapIndexedNotNull<R>(R Function(int index, T) transform) {
    final mapped = mapIndexedNotNullTo(mutableListOf<R>(), transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return mapped;
  }

  @override
  C mapIndexedNotNullTo<R, C extends KtMutableCollection<R>>(
      C destination, R Function(int index, T) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    var index = 0;
    for (final item in iter) {
      final element = transform(index++, item);
      if (element != null) {
        destination.add(element);
      }
    }
    return destination;
  }

  @override
  C mapIndexedTo<R, C extends KtMutableCollection<R>>(
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
  KtList<R> mapNotNull<R>(R Function(T) transform) {
    final mapped = mapNotNullTo(mutableListOf<R>(), transform);
    // TODO ping dort-lang/sdk team to check type bug
    // When in single line: type 'DartMutableList<String>' is not a subtype of type 'Null'
    return mapped;
  }

  @override
  C mapNotNullTo<R, C extends KtMutableCollection<R>>(
      C destination, R Function(T) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      return true;
    }());
    for (final item in iter) {
      final result = transform(item);
      if (result != null) {
        destination.add(result);
      }
    }
    return destination;
  }

  @override
  C mapTo<R, C extends KtMutableCollection<R>>(
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
    if (this is! KtIterable<num>) {
      throw ArgumentError(
          "sum is only supported for type KtIterable<num>, not $runtimeType");
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
    if (this is! KtIterable<num>) {
      throw ArgumentError(
          "sum is only supported for type KtIterable<num>, not $runtimeType");
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
  KtList<T> minus(KtIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    if (this is KtCollection && (this as KtCollection).isEmpty()) {
      return toList();
    }
    return filterNot((it) => elements.contains(it));
  }

  @override
  KtList<T> operator -(KtIterable<T> other) => minus(other);

  @override
  KtList<T> minusElement(T element) {
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
    if (this is KtCollection && (this as KtCollection).isEmpty()) return true;
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
  KPair<KtList<T>, KtList<T>> partition(bool Function(T) predicate) {
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
  KtList<T> plus(KtIterable<T> elements) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    final result = mutableListOf<T>();
    result.addAll(asIterable());
    result.addAll(elements);
    return result;
  }

  @override
  KtList<T> operator +(KtIterable<T> elements) => plus(elements);

  @override
  KtList<T> plusElement(T element) {
    final result = mutableListOf<T>();
    result.addAll(asIterable());
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
  KtIterable<T> requireNoNulls() {
    for (final element in iter) {
      if (element == null) {
        throw ArgumentError("null element found in $this.");
      }
    }
    return this;
  }

  @override
  KtList<T> reversed() {
    if (this is KtCollection && (this as KtCollection).size <= 1)
      return toList();
    final list = toMutableList();
    list.reverse();
    return list;
  }

  @override
  T single([bool Function(T) predicate]) {
    if (predicate == null) {
      final i = iterator();
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

  @override
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
  KtList<T> sorted() => sortedWith(naturalOrder());

  @override
  KtList<T> sortedBy<R extends Comparable<R>>(R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    return sortedWith(compareBy(selector));
  }

  @override
  KtList<T> sortedByDescending<R extends Comparable<R>>(
      R Function(T) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    return sortedWith(compareByDescending(selector));
  }

  @override
  KtList<T> sortedDescending() => sortedWith(reverseOrder());

  @override
  KtList<T> sortedWith(Comparator<T> comparator) {
    assert(() {
      if (comparator == null) throw ArgumentError("comparator can't be null");
      return true;
    }());
    final mutableList = toMutableList();
    mutableList.list.sort(comparator);
    return mutableList;
  }

  @override
  KtSet<T> subtract(KtIterable<T> other) {
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
    if (this is! KtIterable<num>) {
      throw ArgumentError(
          "sum is only supported for type KtIterable<num>, not $runtimeType");
    }

    num sum = 0;
    for (final element in iter) {
      sum += element as num;
    }
    return sum;
  }

  @override
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

  @override
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
  KtList<T> take(int n) {
    assert(() {
      if (n == null) throw ArgumentError("n can't be null");
      return true;
    }());
    if (n < 0) {
      throw ArgumentError("Requested element count $n is less than zero.");
    }
    if (n == 0) return emptyList();
    if (this is KtCollection) {
      final collection = this as KtCollection;
      if (n >= collection.size) return toList();

      if (n == 1) {
        // can't use listOf here because first() might return null
        return listFrom([first()]);
      }
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

  @override
  C toCollection<C extends KtMutableCollection<dynamic>>(C destination) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (mutableListOf<T>() is! C)
        throw ArgumentError(
            "toCollection destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$T>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      return true;
    }());
    for (final item in iter) {
      destination.add(item);
    }
    return destination;
  }

  @override
  KtMutableSet<T> toHashSet() => hashSetFrom(iter);

  @override
  KtList<T> toList() => listFrom(iter);

  @override
  KtMutableList<T> toMutableList() => mutableListFrom(iter);

  @override
  KtMutableSet<T> toMutableSet() => linkedSetFrom(iter);

  @override
  KtSet<T> toSet() => linkedSetFrom(iter);

  @override
  KtSet<T> union(KtIterable<T> other) {
    assert(() {
      if (other == null) throw ArgumentError("other can't be null");
      return true;
    }());
    final set = toMutableSet();
    set.addAll(other);
    return set;
  }

  @override
  KtList<KtList<T>> windowed(int size,
      {int step = 1, bool partialWindows = false}) {
    assert(() {
      if (size == null) throw ArgumentError("size can't be null");
      if (step == null) throw ArgumentError("step can't be null");
      if (partialWindows == null)
        throw ArgumentError("partialWindows can't be null");
      return true;
    }());
    final list = toList();
    final thisSize = list.size;
    final result = mutableListOf<KtList<T>>();
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
  KtList<R> windowedTransform<R>(int size, R Function(KtList<T>) transform,
      {int step = 1, bool partialWindows = false}) {
    assert(() {
      if (size == null) throw ArgumentError("size can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      if (step == null) throw ArgumentError("step can't be null");
      if (partialWindows == null)
        throw ArgumentError("partialWindows can't be null");
      return true;
    }());
    final list = toList();
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
  KtList<KPair<T, R>> zip<R>(KtIterable<R> other) =>
      zipTransform(other, (T a, R b) => KPair(a, b));

  @override
  KtList<V> zipTransform<R, V>(
      KtIterable<R> other, V Function(T a, R b) transform) {
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
  KtList<KPair<T, T>> zipWithNext<R>() =>
      zipWithNextTransform((a, b) => KPair(a, b));

  @override
  KtList<R> zipWithNextTransform<R>(R Function(T a, T b) transform) {
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

  KtList<T> list;
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
    _fromIndex = fromIndex;
    _size = toIndex - fromIndex;
  }

  KtList<T> snapshot() => list.subList(_fromIndex, _fromIndex + _size);

  int get size => _size;
}
