import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/util/errors.dart';

abstract class KtMapExtensionsMixin<K, V>
    implements KtMapExtension<K, V>, KtMap<K, V> {
  @override
  KtMap<K, V> filter(bool Function(KtMapEntry<K, V> entry) predicate) {
    final filtered = filterTo(linkedMapFrom<K, V>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    return filtered;
  }

  @override
  KtMap<K, V> filterKeys(bool Function(K) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    final result = linkedMapFrom<K, V>();
    for (final entry in entries.iter) {
      if (predicate(entry.key)) {
        result.put(entry.key, entry.value);
      }
    }
    return result;
  }

  @override
  KtMap<K, V> filterValues(bool Function(V) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    final result = linkedMapFrom<K, V>();
    for (final entry in entries.iter) {
      if (predicate(entry.value)) {
        result.put(entry.key, entry.value);
      }
    }
    return result;
  }

  @override
  M filterTo<M extends KtMutableMap<dynamic, dynamic>>(
      M destination, bool Function(KtMapEntry<K, V> entry) predicate) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (predicate == null) throw ArgumentError("predicate can't be null");
      if (destination is! KtMutableMap<K, V> && mutableMapFrom<K, V>() is! M)
        throw ArgumentError("filterTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$K, $V>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      return true;
    }());
    for (final element in entries.iter) {
      if (predicate(element)) {
        destination.put(element.key, element.value);
      }
    }
    return destination;
  }

  @override
  KtMap<K, V> filterNot(bool Function(KtMapEntry<K, V> entry) predicate) {
    final filtered = filterNotTo(linkedMapFrom<K, V>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    return filtered;
  }

  @override
  M filterNotTo<M extends KtMutableMap<dynamic, dynamic>>(
      M destination, bool Function(KtMapEntry<K, V> entry) predicate) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (predicate == null) throw ArgumentError("predicate can't be null");
      if (destination is! KtMutableMap<K, V> && mutableMapFrom<K, V>() is! M)
        throw ArgumentError("filterNotTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$K, $V>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      return true;
    }());
    for (final element in entries.iter) {
      if (!predicate(element)) {
        destination.put(element.key, element.value);
      }
    }
    return destination;
  }

  @override
  V getOrElse(K key, V Function() defaultValue) {
    assert(() {
      if (defaultValue == null)
        throw ArgumentError("defaultValue can't be null");
      return true;
    }());
    return get(key) ?? defaultValue();
  }

  @override
  V getValue(K key) {
    final value = get(key);
    if (value == null) {
      throw NoSuchElementException("Key $key is missing in the map.");
    }
    return value;
  }

  @override
  KtIterator<KtMapEntry<K, V>> iterator() => entries.iterator();

  @override
  bool isNotEmpty() => !isEmpty();

  @override
  KtMap<R, V> mapKeys<R>(R Function(KtMapEntry<K, V>) transform) {
    final mapped = mapKeysTo(linkedMapFrom<R, V>(), transform);
    return mapped;
  }

  @override
  M mapKeysTo<R, M extends KtMutableMap<dynamic, dynamic>>(
      M destination, R Function(KtMapEntry<K, V> entry) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      if (destination is! KtMutableMap<R, V> && mutableMapFrom<R, V>() is! M)
        throw ArgumentError("mapKeysTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$R, $V>, Actual: ${destination.runtimeType}"
            "\nEntries after key transformation with $transform have type KtMapEntry<$R, $V> "
            "and can't be copied into destination of type ${destination.runtimeType}."
            "\n\n$kBug35518GenericTypeError");
      return true;
    }());
    for (var element in entries.iter) {
      destination.put(transform(element), element.value);
    }
    return destination;
  }

  @override
  KtMap<K, R> mapValues<R>(R Function(KtMapEntry<K, V>) transform) {
    final mapped = mapValuesTo(linkedMapFrom<K, R>(), transform);
    return mapped;
  }

  @override
  M mapValuesTo<R, M extends KtMutableMap<dynamic, dynamic>>(
      M destination, R Function(KtMapEntry<K, V> entry) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      if (destination is! KtMutableMap<K, R> && mutableMapFrom<K, R>() is! M)
        throw ArgumentError("mapValuesTo destination has wrong type parameters."
            "\nExpected: KtMutableMap<$K, $R>, Actual: ${destination.runtimeType}"
            "\nEntries after key transformation with $transform have type KtMapEntry<$K, $R> "
            "and can't be copied into destination of type ${destination.runtimeType}."
            "\n\n$kBug35518GenericTypeError");
      return true;
    }());
    for (var element in entries.iter) {
      destination.put(element.key, transform(element));
    }
    return destination;
  }

  @override
  KtMap<K, V> minus(K key) {
    return toMutableMap()..remove(key);
  }

  @override
  KtMap<K, V> operator -(K key) => minus(key);

  @override
  KtMap<K, V> plus(KtMap<K, V> map) {
    assert(() {
      if (map == null) throw ArgumentError("map can't be null");
      return true;
    }());
    return toMutableMap()..putAll(map);
  }

  @override
  KtMap<K, V> operator +(KtMap<K, V> map) => plus(map);

  @override
  KtMap<K, V> toMap() {
    if (size == 0) return emptyMap();
    return toMutableMap();
  }

  @override
  KtMutableMap<K, V> toMutableMap() {
    return mutableMapFrom(map);
  }

  @override
  void forEach(Function(K key, V value) action) {
    assert(() {
      if (action == null) throw ArgumentError("action can't be null");
      return true;
    }());
    entries.forEach((entry) => action(entry.key, entry.value));
  }

  @override
  bool none(Function(K key, V value) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    if (isEmpty()) {
      return true;
    }
    for (KtMapEntry<K, V> entry in entries.iter) {
      if (predicate(entry.key, entry.value)) {
        return false;
      }
    }
    return true;
  }

  @override
  bool all(Function(K key, V value) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    if (isEmpty()) {
      return true;
    }
    for (KtMapEntry<K, V> entry in entries.iter) {
      if (!predicate(entry.key, entry.value)) {
        return false;
      }
    }
    return true;
  }

  @override
  bool any(Function(K key, V value) predicate) {
    assert(() {
      if (predicate == null) throw ArgumentError("predicate can't be null");
      return true;
    }());
    if (isEmpty()) {
      return false;
    }
    for (KtMapEntry<K, V> entry in entries.iter) {
      if (predicate(entry.key, entry.value)) {
        return true;
      }
    }
    return false;
  }

  @override
  String toString() {
    return entries.joinToString(
        separator: ", ", prefix: "{", postfix: "}", transform: _entryToString);
  }

  String _entryToString(KtMapEntry<K, V> entry) =>
      "${_toString(entry.key)}=${_toString(entry.value)}";

  String _toString(Object o) =>
      identical(o, this) ? "(this Map)" : o.toString();
}
