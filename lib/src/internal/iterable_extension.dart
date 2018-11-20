import 'dart:collection';

import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/list_mutable.dart';
import 'package:dart_kollection/src/internal/map_mutable.dart';
import 'package:dart_kollection/src/k_iterable.dart';

abstract class KIterableExtensionsMixin<T> implements KIterableExtension<T>, KIterable<T> {
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
  KList<T> flatMap<R>(KIterable<R> Function(T) transform) {
    final KMutableCollection<R> list = DartMutableList<R>(LinkedHashSet<R>());
    return flatMapTo(list, transform);
  }

  @override
  C flatMapTo<R, C extends KMutableCollection<R>>(C destination, KIterable<R> Function(T) transform) {
    for (var element in iter) {
      final list = transform(element);
      destination.addAll(list);
    }
    return destination;
  }

  @override
  void forEach(void action(T element)) {
    var i = iterator();
    while (i.hasNext()) {
      var element = i.next();
      action(element);
    }
  }

  KIterable<R> map<R>(R Function(T) transform) {
    final KMutableList<R> list = mutableListOf<R>();
    return mapTo(list, transform);
  }

  C mapTo<R, C extends KMutableCollection<R>>(C destination, R Function(T) transform) {
    for (var item in iter) {
      destination.add(transform(item));
    }
    return destination;
  }

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
}
