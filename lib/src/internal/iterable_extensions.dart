import 'dart:collection';

import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/map_mutable.dart';
import 'package:dart_kollection/src/k_iterable.dart';

abstract class KIterableExtensionsMixin<T> implements KIterableExtensions<T>, KIterable<T> {
  Iterable<T> get iter => _DartInteropIterable<T>(this);

  @override
  void forEach(void action(T element)) {
    var i = iterator();
    while (i.hasNext()) {
      var element = i.next();
      action(element);
    }
  }

  @override
  bool any([bool Function(T element) predicate = null]) {
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

  bool all([bool Function(T element) predicate = null]) {
    if (this is KCollection && (this as KCollection).isEmpty()) return true;
    for (var element in iter) {
      if (!predicate(element)) {
        return false;
      }
    }
    return true;
  }

  @override
  KIterable<T> asIterable() => this;

  @override
  KMap<K, V> associate<K, V>(KPair<K, V> Function(T) transform) {
    return associateTo(DartMutableMap(LinkedHashMap<K, V>()), transform);
  }

  @override
  KMap<K, V> associateBy<K, V>(K Function(T) keySelector, [V Function(T) valueTransform]) {
    return associateByTo(DartMutableMap(LinkedHashMap<K, V>()), keySelector, valueTransform);
  }

  @override
  M associateByTo<K, V, M extends KMutableMap<K, V>>(M destination, K Function(T) keySelector,
      [V Function(T) valueTransform]) {
    for (var element in iter) {
      var key = keySelector(element);
      var value = valueTransform == null ? element : valueTransform(element);
      destination.put(key, value);
    }
    return destination;
  }

  @override
  M associateTo<K, V, M extends KMutableMap<K, V>>(M destination, KPair<K, V> Function(T) transform) {
    for (var element in iter) {
      var pair = transform(element);
      destination.put(pair.first, pair.second);
    }
    return destination;
  }

  @override
  KMap<T, V> associateWith<V>(V Function(T) valueSelector) {
    return associateWithTo(DartMutableMap(LinkedHashMap<T, V>()), valueSelector);
  }

  @override
  M associateWithTo<V, M extends KMutableMap<T, V>>(M destination, V Function(T) valueSelector) {
    for (var element in iter) {
      destination.put(element, valueSelector(element));
    }
    return destination;
  }

  @override
  KIterator<T> iterator() {
    // TODO: implement iterator
  }
}

class _DartInteropIterable<T> extends Iterable<T> {
  _DartInteropIterable(this.kIterable);

  final KIterable<T> kIterable;

  @override
  Iterator<T> get iterator => _DartInteropIterator(kIterable.iterator());
}

class _DartInteropIterator<T> extends Iterator<T> {
  _DartInteropIterator(this.kIterator);

  final KIterator<T> kIterator;

  @override
  T current = null;

  @override
  bool moveNext() {
    var hasNext = kIterator.hasNext();
    if (hasNext) {
      current = kIterator.next();
      return true;
    } else {
      current = null;
      return false;
    }
  }
}
