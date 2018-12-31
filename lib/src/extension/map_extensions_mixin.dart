import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/k_map_mutable.dart';
import 'package:dart_kollection/src/util/errors.dart';

abstract class KMapExtensionsMixin<K, V>
    implements KMapExtension<K, V>, KMap<K, V> {
  @override
  KMap<K, V> filter(bool Function(KMapEntry<K, V> entry) predicate) {
    final filtered = filterTo(linkedMapOf<K, V>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    return filtered;
  }

  @override
  M filterTo<M extends KMutableMap<dynamic, dynamic>>(
      M destination, bool Function(KMapEntry<K, V> entry) predicate) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (mutableMapOf<K, V>() is! M)
        throw ArgumentError("filterTo destination has wrong type parameters."
            "\nExpected: KMutableMap<$K, $V>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      if (predicate == null) throw ArgumentError("predicate can't be null");
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
  KMap<K, V> filterNot(bool Function(KMapEntry<K, V> entry) predicate) {
    final filtered = filterNotTo(linkedMapOf<K, V>(), predicate);
    // TODO ping dort-lang/sdk team to check type bug
    return filtered;
  }

  @override
  M filterNotTo<M extends KMutableMap<dynamic, dynamic>>(
      M destination, bool Function(KMapEntry<K, V> entry) predicate) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (mutableMapOf<K, V>() is! M)
        throw ArgumentError("filterNotTo destination has wrong type parameters."
            "\nExpected: KMutableMap<$K, $V>, Actual: ${destination.runtimeType}"
            "\ndestination (${destination.runtimeType}) entries aren't subtype of "
            "map ($runtimeType) entries. Entries can't be copied to destination."
            "\n\n$kBug35518GenericTypeError");
      if (predicate == null) throw ArgumentError("predicate can't be null");
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
  KIterator<KMapEntry<K, V>> iterator() => entries.iterator();

  @override
  bool isNotEmpty() => !isEmpty();

  @override
  KMap<R, V> mapKeys<R>(R Function(KMapEntry<K, V>) transform) {
    final mapped = mapKeysTo(linkedMapOf<R, V>(), transform);
    return mapped;
  }

  @override
  M mapKeysTo<R, M extends KMutableMap<dynamic, dynamic>>(
      M destination, R Function(KMapEntry<K, V> entry) transform) {
    assert(() {
      if (destination == null) throw ArgumentError("destination can't be null");
      if (transform == null) throw ArgumentError("transform can't be null");
      final testType = mutableMapOf<R, V>();
      if (testType is! M)
        throw ArgumentError("mapKeysTo destination has wrong type parameters."
            "\nExpected: KMutableMap<$R, $V>, Actual: ${destination.runtimeType}"
            "\nEntries after key transformation with $transform have type KMapEntry<$R, $V> "
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
  KMap<K, R> mapValues<R>(R Function(KMapEntry<K, V>) transform) {
    final mapped = mapValuesTo(linkedMapOf<K, R>(), transform);
    return mapped;
  }

  M mapValuesTo<R, M extends KMutableMap<K, R>>(
      M destination, R Function(KMapEntry<K, V> entry) transform) {
    return entries.associateByTo(destination, (it) => it.key, transform);
  }

  @override
  KMap<K, V> minus(K key) {
    return toMutableMap()..remove(key);
  }

  @override
  KMap<K, V> operator -(K key) => minus(key);

  @override
  KMap<K, V> plus(KMap<K, V> map) {
    assert(() {
      if (map == null) throw ArgumentError("map can't be null");
      return true;
    }());
    return toMutableMap()..putAll(map);
  }

  @override
  KMap<K, V> operator +(KMap<K, V> map) => plus(map);

  @override
  KMap<K, V> toMap() {
    if (size == 0) return emptyMap();
    return toMutableMap();
  }

  @override
  KMutableMap<K, V> toMutableMap() {
    return mutableMapOf(map);
  }

  @override
  String toString() {
    return entries.joinToString(
        separator: ", ", prefix: "{", postfix: "}", transform: _entryToString);
  }

  String _entryToString(KMapEntry<K, V> entry) =>
      "${_toString(entry.key)}=${_toString(entry.value)}";

  String _toString(Object o) =>
      identical(o, this) ? "(this Map)" : o.toString();
}
