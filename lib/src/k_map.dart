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
abstract class KMap<K, V> implements KMapExtension<K, V> {
  /**
   * dart interop map for time critical operations such as sorting
   */
  Map<K, V> get map;

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
  @nullable
  V get(K key);

  /**
   * Returns the value corresponding to the given [key], or `null` if such a key is not present in the map.
   */
  @nullable
  V operator [](K key);

  /**
   * Returns the value corresponding to the given [key], or [defaultValue] if such a key is not present in the map.
   */
  @nullable
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
  @nullable
  V get value;

  /**
   * Converts entry to [Pair] with key being first component and value being second.
   */
  KPair<K, V> toPair();
}

abstract class KMapExtension<K, V> {
  /**
   * Returns the value for the given key, or the result of the [defaultValue] function if there was no entry for the given key.
   */
  V getOrElse(K key, V Function() defaultValue);

  /**
   * Returns the value for the given [key] or throws an exception if there is no such key in the map.
   *
   * @throws NoSuchElementException when the map doesn't contain a value for the specified key
   */
  @nonNull
  V getValue(K key);

  // TODO filter
  // TODO filterTo
  // TODO filterNot
  // TODO filterNotTo

  /**
   * Returns an [Iterator] over the entries in the [Map].
   */
  KIterator<KMapEntry<K, V>> iterator();

  /**
   * Returns `true` if this map is not empty.
   */
  bool isNotEmpty();

  /**
   * Returns a new Map with entries having the keys obtained by applying the [transform] function to each entry in this
   * [Map] and the values of this map.
   *
   * In case if any two entries are mapped to the equal keys, the value of the latter one will overwrite
   * the value associated with the former one.
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KMap<R, V> mapKeys<R>(R Function(KMapEntry<K, V>) transform);

  /**
   * Populates the given [destination] map with entries having the keys obtained
   * by applying the [transform] function to each entry in this [Map] and the values of this map.
   *
   * In case if any two entries are mapped to the equal keys, the value of the latter one will overwrite
   * the value associated with the former one.
   */
  // TODO add after https://github.com/dart-lang/sdk/issues/35518 has been fixed
  // M mapKeysTo<R, M extends KMutableMap<R, V>>(
  //     M destination, R Function(KMapEntry<K, V> entry) transform);

  /**
   * Returns a new map with entries having the keys of this map and the values obtained by applying the [transform]
   * function to each entry in this [Map].
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KMap<K, R> mapValues<R>(R Function(KMapEntry<K, V>) transform);

  /**
   * Populates the given [destination] map with entries having the keys of this map and the values obtained
   * by applying the [transform] function to each entry in this [Map].
   */
  // TODO add after https://github.com/dart-lang/sdk/issues/35518 has been fixed
  // M mapValuesTo<R, M extends KMutableMap<K, R>>(
  //     M destination, R Function(KMapEntry<K, V> entry) transform);

  /**
   * Returns a map containing all entries of the original map except the entry with the given [key].
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KMap<K, V> minus(K key);

  /**
   * Returns a map containing all entries of the original map except the entry with the given [key].
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KMap<K, V> operator -(K key);

  /**
   * Creates a new read-only map by replacing or adding entries to this map from another [map].
   *
   * The returned map preserves the entry iteration order of the original map.
   * Those entries of another [map] that are missing in this map are iterated in the end in the order of that [map].
   */
  KMap<K, V> plus(KMap<K, V> map);

  /**
   * Creates a new read-only map by replacing or adding entries to this map from another [map].
   *
   * The returned map preserves the entry iteration order of the original map.
   * Those entries of another [map] that are missing in this map are iterated in the end in the order of that [map].
   */
  KMap<K, V> operator +(KMap<K, V> map);

  /**
   * Returns a new read-only map containing all key-value pairs from the original map.
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KMap<K, V> toMap();

  /**
   * Returns a new mutable map containing all key-value pairs from the original map.
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KMutableMap<K, V> toMutableMap();
}
