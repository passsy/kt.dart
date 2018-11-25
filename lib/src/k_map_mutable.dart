import 'package:dart_kollection/dart_kollection.dart';

/**
 * A modifiable collection that holds pairs of objects (keys and values) and supports efficiently retrieving
 * the value corresponding to each key. Map keys are unique; the map holds only one value for each key.
 * @param K the type of map keys. The map is invariant on its key type.
 * @param V the type of map values. The mutable map is invariant on its value type.
 */
abstract class KMutableMap<K, V> implements KMap<K, V>, KMutableMapExtension<K, V> {
  // Modification Operations
  /**
   * Associates the specified [value] with the specified [key] in the map.
   *
   * @return the previous value associated with the key, or `null` if the key was not present in the map.
   */
  @nullable
  V put(K key, V value);

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
  void putAll(KMap<K, V> from);

  /**
   * Removes all elements from this map.
   */
  void clear();

  // Views

  /**
   * Returns a [MutableSet] of all keys in this map.
   */
  @override
  KMutableSet<K> get keys;

  /**
   * Returns a [MutableCollection] of all values in this map. Note that this collection may contain duplicate values.
   */
  @override
  KMutableCollection<V> get values;

  /**
   * Returns a [MutableSet] of all key/value pairs in this map.
   */
  @override
  KMutableSet<KMutableEntry<K, V>> get entries;
}

/**
 * Represents a key/value pair held by a [KMutableMap].
 */
abstract class KMutableEntry<K, V> extends KMapEntry<K, V> {
  /**
   * Changes the value associated with the key of this entry.
   *
   * @return the previous value corresponding to the key.
   */
  @nullable
  V setValue(V newValue);
}

abstract class KMutableMapExtension<K, V> {
  /**
   * Returns the value for the given key. If the key is not found in the map, calls the [defaultValue] function,
   * puts its result into the map under the given key and returns it.
   *
   * Note that the operation is not guaranteed to be atomic if the map is being modified concurrently.
   */
  V getOrPut(K key, V Function() defaultValue);

  /**
   * Puts all the given [pairs] into this [MutableMap] with the first component in the pair being the key and the second the value.
   */
  void putAllPairs(KIterable<KPair<K, V>> pairs);
}
