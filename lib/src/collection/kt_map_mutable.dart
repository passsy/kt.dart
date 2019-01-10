import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/impl/map_mutable.dart';

/**
 * A modifiable collection that holds pairs of objects (keys and values) and supports efficiently retrieving
 * the value corresponding to each key. Map keys are unique; the map holds only one value for each key.
 * @param K the type of map keys. The map is invariant on its key type.
 * @param V the type of map values. The mutable map is invariant on its value type.
 */
abstract class KtMutableMap<K, V>
    implements KtMap<K, V>, KtMutableMapExtension<K, V> {
  factory KtMutableMap.empty() => DartMutableMap<K, V>();

  factory KtMutableMap.from([Map<K, V> map = const {}]) => DartMutableMap(map);

  // Modification Operations
  /**
   * Associates the specified [value] with the specified [key] in the map.
   *
   * @return the previous value associated with the key, or `null` if the key was not present in the map.
   */
  @nullable
  V put(K key, V value);

  /**
   * Associates the specified [value] with the specified [key] in the map.
   */
  void operator []=(K key, V value);

  /**
   * Removes the specified key and its corresponding value from this map.
   *
   * @return the previous value associated with the key, or `null` if the key was not present in the map.
   */
  @nullable
  V remove(K key);

  /**
   * Removes the entry for the specified key only if it is mapped to the specified value.
   *
   * @return true if entry was removed
   */
  bool removeMapping(K key, V value);

  // Bulk Modification Operations
  /**
   * Updates this map with key/value pairs from the specified map [from].
   */
  void putAll(KtMap<K, V> from);

  /**
   * Removes all elements from this map.
   */
  void clear();

  // Views

  /**
   * Returns a [MutableSet] of all keys in this map.
   */
  @override
  KtMutableSet<K> get keys;

  /**
   * Returns a [MutableCollection] of all values in this map. Note that this collection may contain duplicate values.
   */
  @override
  KtMutableCollection<V> get values;

  /**
   * Returns a [MutableSet] of all key/value pairs in this map.
   */
  @override
  KtMutableSet<KtMutableMapEntry<K, V>> get entries;
}

/**
 * Represents a key/value pair held by a [KtMutableMap].
 */
abstract class KtMutableMapEntry<K, V> extends KtMapEntry<K, V> {
  /**
   * Changes the value associated with the key of this entry.
   *
   * @return the previous value corresponding to the key.
   */
  @nullable
  V setValue(V newValue);
}

abstract class KtMutableMapExtension<K, V> {
  /**
   * Returns the value for the given key. If the key is not found in the map, calls the [defaultValue] function,
   * puts its result into the map under the given key and returns it.
   *
   * Note that the operation is not guaranteed to be atomic if the map is being modified concurrently.
   */
  @nonNull
  V getOrPut(K key, V Function() defaultValue);

  /**
   * Returns an [Iterator] over the entries in the [Map].
   */
  KtMutableIterator<KtMutableMapEntry<K, V>> iterator();

  /**
   * Puts all the given [pairs] into this [MutableMap] with the first component in the pair being the key and the second the value.
   */
  void putAllPairs(KtIterable<KtPair<K, V>> pairs);

  /**
   * If the specified key is not already associated with a value (or is mapped to `null`) associates it with the given value and returns `null`, else returns the current value.
   *
   *  return the previous value associated with the specified key, or `null` if there was no mapping for the key. (A `null` return can also indicate that the map previously associated `null` with the key, if the implementation supports `null` values.)
   */
  @nullable
  V putIfAbsent(K key, V value);
}
