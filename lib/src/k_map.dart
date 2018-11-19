import 'package:dart_kollection/dart_kollection.dart';

/**
 * A collection that holds pairs of objects (keys and values) and supports efficiently retrieving
 * the value corresponding to each key. Map keys are unique; the map holds only one value for each key.
 * Methods in this interface support only read-only access to the map; read-write access is supported through
 * the [KMutableMap] interface.
 * @param K the type of map keys. The map is invariant on its key type, as it
 *          can accept key as a parameter (of [containsKey] for example) and return it in [keys] set.
 * @param V the type of map values. The map is covariant on its value type.
 */
abstract class KMap<K, V> {
  // Query Operations
  /**
   * Returns the number of key/value pairs in the map.
   */
  int get size;

  /**
   * Returns `true` if the map is empty (contains no elements), `false` otherwise.
   */
  bool isEmpty();

  /**
   * Returns `true` if the map contains the specified [key].
   */
  bool containsKey(K key);

  /**
   * Returns `true` if the map maps one or more keys to the specified [value].
   */
  bool containsValue(V value);

  /**
   * Returns the value corresponding to the given [key], or `null` if such a key is not present in the map.
   */
  // TODO add nullable annotation
  V get(K key);

  /**
   * Returns the value corresponding to the given [key], or `null` if such a key is not present in the map.
   */
  // TODO add nullable annotation
  V operator [](K key);

  /**
   * Returns the value corresponding to the given [key], or [defaultValue] if such a key is not present in the map.
   *
   * @since JDK 1.8
   */
  V getOrDefault(K key, V defaultValue);

  // Views
  /**
   * Returns a read-only [KSet] of all keys in this map.
   */
  KSet<K> get keys;

  /**
   * Returns a read-only [KCollection] of all values in this map. Note that this collection may contain duplicate values.
   */
  KCollection<V> get values;

  /**
   * Returns a read-only [KSet] of all key/value pairs in this map.
   */
  KSet<KMapEntry<K, V>> get entries;
}

/**
 * Represents a key/value pair held by a [KMap].
 */
abstract class KMapEntry<K, V> {
  /**
   * Returns the key of this key/value pair.
   */
  K get key;

  /**
   * Returns the value of this key/value pair.
   */
  V get value;
}
