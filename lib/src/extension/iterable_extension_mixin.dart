import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/k_iterable.dart';

abstract class KIterableExtensionsMixin<T> implements KIterableExtension<T>, KIterable<T> {
  @override
  bool all([bool Function(T element) predicate]) {
    assert(predicate != null);
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
  KMap<K, V> associateBy<K, V>(K Function(T) keySelector, [V Function(T) valueTransform]) {
    return associateByTo(linkedMapOf<K, V>(), keySelector, valueTransform);
  }

  @override
  M associateByTo<K, V, M extends KMutableMap<K, V>>(M destination, K Function(T) keySelector,
      [V Function(T) valueTransform]) {
    assert(valueTransform != null);
    for (var element in iter) {
      var key = keySelector(element);
      var value = valueTransform == null ? element : valueTransform(element);
      destination.put(key, value);
    }
    return destination;
  }

  @override
  M associateTo<K, V, M extends KMutableMap<K, V>>(M destination, KPair<K, V> Function(T) transform) {
    assert(transform != null);
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

  @override
  M associateWithTo<V, M extends KMutableMap<T, V>>(M destination, V Function(T) valueSelector) {
    assert(valueSelector != null);
    for (var element in iter) {
      destination.put(element, valueSelector(element));
    }
    return destination;
  }

  @override
  bool contains(T element) {
    if (this is KCollection) return (this as KCollection).contains(element);
    return indexOf(element) >= 0;
  }

  @override
  KList<T> drop(int n) {
    if (n < 0) throw ArgumentError("Requested element count $n is less than zero.");
    return listOf(iter.skip(n));
  }

  @override
  T elementAt(int index) {
    if (this is KList) {
      return (this as KList).get(index);
    }
    return elementAtOrElse(index, (int index) {
      throw IndexOutOfBoundsException("Collection doesn't contain element at index $index.");
    });
  }

  @override
  KIterable<T> dropWhile([bool Function(T) predicate]) {
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
  T elementAtOrElse(int index, T Function(int) defaultValue) {
    assert(defaultValue != null);
    if (this is KList) {
      return (this as KList).getOrElse(index, defaultValue);
    }
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
    if (this is KList) {
      return (this as KList).getOrNull(index);
    }
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
  T find(bool Function(T) predicate) {
    assert(predicate != null);
    return firstOrNull(predicate);
  }

  @override
  T findLast(bool Function(T) predicate) {
    assert(predicate != null);
    return lastOrNull(predicate);
  }

  @override
  T first([bool Function(T) predicate]) {
    if (predicate == null) {
      if (this is KList) return (this as KList).first();
      final i = iterator();
      if (!i.hasNext()) {
        throw NoSuchElementException("Collection is empty");
      }
      return i.next();
    } else {
      for (var element in iter) {
        if (predicate(element)) return element;
      }
      throw NoSuchElementException("Collection contains no element matching the predicate.");
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
        throw NoSuchElementException("Collection is empty");
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
  C flatMapTo<R, C extends KMutableCollection<R>>(C destination, KIterable<R> Function(T) transform) {
    assert(transform != null);
    for (var element in iter) {
      final list = transform(element);
      destination.addAll(list);
    }
    return destination;
  }

  @override
  void forEach(void action(T element)) {
    assert(action != null);
    var i = iterator();
    while (i.hasNext()) {
      var element = i.next();
      action(element);
    }
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
    assert(predicate != null);
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
    assert(predicate != null);
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
      if (!found) throw NoSuchElementException("Collection contains no element matching the predicate.");
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
        return list.isEmpty() ? null : list.get(0);
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
  KIterable<R> map<R>(R Function(T) transform) {
    final KMutableList<R> list = mutableListOf<R>();
    return mapTo(list, transform);
  }

  @override
  C mapTo<R, C extends KMutableCollection<R>>(C destination, R Function(T) transform) {
    assert(transform != null);
    for (var item in iter) {
      destination.add(transform(item));
    }
    return destination;
  }

  @override
  T single([bool Function(T) predicate]) {
    if (predicate == null) {
      if (this is KList) return (this as KList).single();
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
          if (found) throw ArgumentError("Collection contains more than one matching element.");
          single = element;
          found = true;
        }
      }
      if (!found) throw NoSuchElementException("Collection contains no element matching the predicate.");
      return single;
    }
  }

  T singleOrNull([bool Function(T) predicate]) {
    if (predicate == null) {
      if (this is KList) {
        final list = (this as KList);
        return list.size == 1 ? list.get(0) : null;
      } else {
        final i = iterator();
        if (!i.hasNext()) return null;
        final single = i.next();
        if (i.hasNext()) {
          return null;
        }
        return single;
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
  KList<T> take(int n) {
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
}
