import "package:kt_dart/collection.dart";
import "package:kt_dart/src/util/errors.dart";

extension KtMapExtensions<K, V> on KtMap<K, V> {
  bool all(Function(K key, V value) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    if (isEmpty()) {
      return true;
    }
    for (final KtMapEntry<K, V> entry in iter) {
      if (!predicate(entry.key, entry.value)) {
        return false;
      }
    }
    return true;
  }

  bool any(Function(K key, V value) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    if (isEmpty()) {
      return false;
    }
    for (final KtMapEntry<K, V> entry in iter) {
      if (predicate(entry.key, entry.value)) {
        return true;
      }
    }
    return false;
  }

  int count([bool Function(KtMapEntry<K, V>) predicate]) {
    if (predicate == null) {
      return size;
    }
    var count = 0;
    final KtIterator<KtMapEntry<K, V>> i = iterator();
    while (i.hasNext()) {
      if (predicate(i.next())) {
        count++;
      }
    }
    return count;
  }

  KtMap<K, V> filter(bool Function(KtMapEntry<K, V> entry) predicate) {
    final filtered = filterTo(linkedMapFrom<K, V>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    return filtered;
  }

  KtMap<K, V> filterKeys(bool Function(K) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    final result = linkedMapFrom<K, V>();
    for (final entry in iter) {
      if (predicate(entry.key)) {
        result.put(entry.key, entry.value);
      }
    }
    return result;
  }

  KtMap<K, V> filterNot(bool Function(KtMapEntry<K, V> entry) predicate) {
    final filtered = filterNotTo(linkedMapFrom<K, V>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    return filtered;
  }

  M filterNotTo<M extends KtMutableMap<dynamic, dynamic>>(
      M destination, bool Function(KtMapEntry<K, V> entry) predicate) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (predicate == null) throw ArgumentError("predicate can't be null");
      if (destination is! KtMutableMap<K, V> && mutableMapFrom<K, V>() is! M) {
        throw ArgumentError("filterNotTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$K, $V>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      if (!predicate(element)) {
        destination.put(element.key, element.value);
      }
    }
    return destination;
  }

  M filterTo<M extends KtMutableMap<dynamic, dynamic>>(
      M destination, bool Function(KtMapEntry<K, V> entry) predicate) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (predicate == null) throw ArgumentError("predicate can't be null");
      if (destination is! KtMutableMap<K, V> && mutableMapFrom<K, V>() is! M) {
        throw ArgumentError("filterTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$K, $V>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      if (predicate(element)) {
        destination.put(element.key, element.value);
      }
    }
    return destination;
  }

  KtMap<K, V> filterValues(bool Function(V) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    final result = linkedMapFrom<K, V>();
    for (final entry in iter) {
      if (predicate(entry.value)) {
        result.put(entry.key, entry.value);
      }
    }
    return result;
  }

  void forEach(Function(K key, V value) action) {
    assert(() {
      if (action == null) throw ArgumentError("action can't be null");
      return true;
    }());
    entries.forEach((entry) => action(entry.key, entry.value));
  }

  V getOrElse(K key, V Function() defaultValue) {
    assert(() {
      if (defaultValue == null) {
        throw ArgumentError("defaultValue can't be null");
      }
      return true;
    }());
    return get(key) ?? defaultValue();
  }

  V getValue(K key) {
    final value = get(key);
    if (value == null) {
      throw NoSuchElementException("Key $key is missing in the map.");
    }
    return value;
  }

  KtIterator<KtMapEntry<K, V>> iterator() => entries.iterator();

  bool isNotEmpty() => !isEmpty();

  KtList<R> map<R>(R Function(KtMapEntry<K, V> entry) transform) {
    final mapped = mapTo(mutableListOf<R>(), transform);
    return mapped;
  }

  KtMap<R, V> mapKeys<R>(R Function(KtMapEntry<K, V>) transform) {
    final mapped = mapKeysTo(linkedMapFrom<R, V>(), transform);
    return mapped;
  }

  M mapKeysTo<R, M extends KtMutableMap<dynamic, dynamic>>(
      M destination, R Function(KtMapEntry<K, V> entry) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      if (destination is! KtMutableMap<R, V> && mutableMapFrom<R, V>() is! M) {
        throw ArgumentError("mapKeysTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$R, $V>, Actual: ${destination.runtimeType}"
            "\nEntries after key transformation with $transform have type KtMapEntry<$R, $V> "
            "and can't be copied into destination of type ${destination.runtimeType}."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      destination.put(transform(element), element.value);
    }
    return destination;
  }

  M mapTo<R, M extends KtMutableCollection<dynamic>>(
      M destination, R Function(KtMapEntry<K, V> entry) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      if (destination is! KtMutableCollection<R> &&
          mutableListFrom<R>() is! M) {
        throw ArgumentError("mapTo destination has wrong type parameters."
            "\nExpected: KtMutableCollection<$R>, Actual: ${destination.runtimeType}"
            "\nEntries after key transformation with $transform have type $R "
            "and can't be copied into destination of type ${destination.runtimeType}."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final item in iter) {
      destination.add(transform(item));
    }
    return destination;
  }

  KtMap<K, R> mapValues<R>(R Function(KtMapEntry<K, V>) transform) {
    final mapped = mapValuesTo(linkedMapFrom<K, R>(), transform);
    return mapped;
  }

  M mapValuesTo<R, M extends KtMutableMap<dynamic, dynamic>>(
      M destination, R Function(KtMapEntry<K, V> entry) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      if (destination is! KtMutableMap<K, R> && mutableMapFrom<K, R>() is! M) {
        throw ArgumentError("mapValuesTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$K, $R>, Actual: ${destination.runtimeType}"
            "\nEntries after key transformation with $transform have type KtMapEntry<$K, $R> "
            "and can't be copied into destination of type ${destination.runtimeType}."
            "\n\n$kBug35518GenericTypeError");
      }
      return true;
    }());
    for (final element in iter) {
      destination.put(element.key, transform(element));
    }
    return destination;
  }

  KtMapEntry<K, V> maxBy<R extends Comparable<R>>(
      R Function(KtMapEntry<K, V>) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    final i = iterator();
    if (!iterator().hasNext()) return null;
    KtMapEntry<K, V> maxElement = i.next();
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

  KtMapEntry<K, V> maxWith(Comparator<KtMapEntry<K, V>> comparator) {
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

  KtMap<K, V> minus(K key) => toMutableMap()..remove(key);

  KtMap<K, V> operator -(K key) => minus(key);

  KtMapEntry<K, V> minBy<R extends Comparable<R>>(
      R Function(KtMapEntry<K, V>) selector) {
    assert(() {
      if (selector == null) throw ArgumentError("selector can't be null");
      return true;
    }());
    final i = iterator();
    if (!iterator().hasNext()) return null;
    KtMapEntry<K, V> minElement = i.next();
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

  KtMapEntry<K, V> minWith(Comparator<KtMapEntry<K, V>> comparator) {
    assert(() {
      if (comparator == null) throw ArgumentError("comparator can't be null");
      return true;
    }());
    final i = iterator();
    if (!i.hasNext()) return null;
    var min = i.next();
    while (i.hasNext()) {
      final e = i.next();
      if (comparator(min, e) > 0) {
        min = e;
      }
    }
    return min;
  }

  bool none(Function(K key, V value) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    if (isEmpty()) {
      return true;
    }
    for (final KtMapEntry<K, V> entry in iter) {
      if (predicate(entry.key, entry.value)) {
        return false;
      }
    }
    return true;
  }

  KtMap<K, V> plus(KtMap<K, V> map) {
    assert(() {
      if (map == null) throw ArgumentError("map can't be null");
      return true;
    }());
    return toMutableMap()..putAll(map);
  }

  KtMap<K, V> operator +(KtMap<K, V> map) => plus(map);

  KtList<KtPair<K, V>> toList() => listFrom(iter.map((it) => it.toPair()));

  KtMap<K, V> toMap() {
    if (size == 0) return emptyMap();
    return toMutableMap();
  }

  KtMutableMap<K, V> toMutableMap() => mutableMapFrom(asMap());
}
