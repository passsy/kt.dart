import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/k_map_mutable.dart';

abstract class KMapExtensionsMixin<K, V> implements KMapExtension<K, V>, KMap<K, V> {
  @override
  V getOrElse(K key, V Function() defaultValue) {
    return get(key) ?? defaultValue();
  }

  @override
  V getValue(K key) {
    var value = get(key);
    if (value == null) {
      throw NoSuchElementException("Key $key is missing in the map.");
    }
    return value;
  }

  KIterator<KMapEntry<K, V>> iterator() => entries.iterator();

  @override
  KMap<R, V> mapKeys<R>(R Function(KMapEntry<K, V>) transform) {
    var mapped = mapKeysTo(linkedMapOf<R, V>(), transform);
    return mapped;
  }

  @override
  M mapKeysTo<R, M extends KMutableMap<R, V>>(M destination, R Function(KMapEntry<K, V> entry) transform) {
    return entries.associateByTo(destination, transform, (it) => it.value);
  }

  @override
  KMap<K, R> mapValues<R>(R Function(KMapEntry<K, V>) transform) {
    var mapped = mapValuesTo(linkedMapOf<K, R>(), transform);
    return mapped;
  }

  @override
  M mapValuesTo<R, M extends KMutableMap<K, R>>(M destination, R Function(KMapEntry<K, V> entry) transform) {
    return entries.associateByTo(destination, (it) => it.key, transform);
  }

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
    return entries.joinToString(separator: ", ", prefix: "{", postfix: "}", transform: (it) => _entryToString(it));
  }

  String _entryToString(KMapEntry<K, V> entry) => _toString(entry.key) + "=" + _toString(entry.value);

  String _toString(Object o) => identical(o, this) ? "(this Map)" : o.toString();
}
