import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/impl/map.dart';
import 'package:kt_dart/src/collection/impl/map_empty.dart';

/**
 * A collection that holds pairs of objects (keys and values) and supports efficiently retrieving
 * the value corresponding to each key. Map keys are unique; the map holds only one value for each key.
 * Methods in this interface support only read-only access to the map; read-write access is supported through
 * the [KtMutableMap] interface.
 * @param K the type of map keys. The map is invariant on its key type, as it
 *          can accept key as a parameter (of [containsKey] for example) and return it in [keys] set.
 * @param V the type of map values. The map is covariant on its value type.
 */
abstract class KtMap<K, V> implements KtMapExtension<K, V> {
  factory KtMap.empty() => EmptyMap<K, V>();

  factory KtMap.from([Map<K, V> map = const {}]) {
    if (map.isEmpty) return EmptyMap<K, V>();
    return DartMap(map);
  }

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
   * Returns a read-only [KtSet] of all keys in this map.
   */
  KtSet<K> get keys;

  /**
   * Returns a read-only [KtCollection] of all values in this map. Note that this collection may contain duplicate values.
   */
  KtCollection<V> get values;

  /**
   * Returns a read-only [KtSet] of all key/value pairs in this map.
   */
  KtSet<KtMapEntry<K, V>> get entries;
}

/**
 * Represents a key/value pair held by a [KtMap].
 */
abstract class KtMapEntry<K, V> {
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
  KtPair<K, V> toPair();
}

abstract class KtMapExtension<K, V> {
  /**
   * Returns a new map containing all key-value pairs matching the given [predicate].
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KtMap<K, V> filter(bool Function(KtMapEntry<K, V> entry) predicate);

  /**
   * Returns a map containing all key-value pairs with keys matching the given [predicate].
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KtMap<K, V> filterKeys(bool Function(K) predicate);

  /**
   * Returns a map containing all key-value pairs with keys matching the given [predicate].
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KtMap<K, V> filterValues(bool Function(V) predicate);

  /**
   * Appends all entries matching the given [predicate] into the mutable map given as [destination] parameter.
   *
   * [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
   * but will be checked at runtime.
   * [M] actually is expected to be `M extends KtMutableMap<K, V>`
   *
   * @return the destination map.
   */
  // TODO Change to `M extends KtMutableMap<K, V>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M filterTo<M extends KtMutableMap<dynamic, dynamic>>(
      M destination, bool Function(KtMapEntry<K, V> entry) predicate);

  /**
   * Returns a new map containing all key-value pairs not matching the given [predicate].
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KtMap<K, V> filterNot(bool Function(KtMapEntry<K, V> entry) predicate);

  /**
   * Appends all entries not matching the given [predicate] into the given [destination].
   *
   * [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
   * but will be checked at runtime.
   * [M] actually is expected to be `M extends KtMutableMap<K, V>`
   *
   * @return the destination map.
   */
  // TODO Change to `M extends KtMutableMap<K, V>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M filterNotTo<M extends KtMutableMap<dynamic, dynamic>>(
      M destination, bool Function(KtMapEntry<K, V> entry) predicate);

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

  /**
   * Returns an [Iterator] over the entries in the [Map].
   */
  KtIterator<KtMapEntry<K, V>> iterator();

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
  KtMap<R, V> mapKeys<R>(R Function(KtMapEntry<K, V>) transform);

  /**
   * Populates the given [destination] map with entries having the keys obtained
   * by applying the [transform] function to each entry in this [Map] and the values of this map.
   *
   * In case if any two entries are mapped to the equal keys, the value of the latter one will overwrite
   * the value associated with the former one.
   *
   * [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
   * but will be checked at runtime.
   * [M] actually is expected to be `M extends KtMutableMap<R, V>`
   */
  // TODO Change to `M extends KtMutableMap<R, V>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M mapKeysTo<R, M extends KtMutableMap<dynamic, dynamic>>(
      M destination, R Function(KtMapEntry<K, V> entry) transform);

  /**
   * Returns a new map with entries having the keys of this map and the values obtained by applying the [transform]
   * function to each entry in this [Map].
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KtMap<K, R> mapValues<R>(R Function(KtMapEntry<K, V>) transform);

  /**
   * Populates the given [destination] map with entries having the keys of this map and the values obtained
   * by applying the [transform] function to each entry in this [Map].
   *
   * [destination] is not type checked by the compiler due to https://github.com/dart-lang/sdk/issues/35518,
   * but will be checked at runtime.
   * [M] actually is expected to be `M extends KtMutableMap<K, R>`
   */
  // TODO Change to `M extends KtMutableMap<K, R>` once https://github.com/dart-lang/sdk/issues/35518 has been fixed
  M mapValuesTo<R, M extends KtMutableMap<dynamic, dynamic>>(
      M destination, R Function(KtMapEntry<K, V> entry) transform);

  /**
   * Returns a map containing all entries of the original map except the entry with the given [key].
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KtMap<K, V> minus(K key);

  /**
   * Returns a map containing all entries of the original map except the entry with the given [key].
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KtMap<K, V> operator -(K key);

  /**
   * Creates a new read-only map by replacing or adding entries to this map from another [map].
   *
   * The returned map preserves the entry iteration order of the original map.
   * Those entries of another [map] that are missing in this map are iterated in the end in the order of that [map].
   */
  KtMap<K, V> plus(KtMap<K, V> map);

  /**
   * Creates a new read-only map by replacing or adding entries to this map from another [map].
   *
   * The returned map preserves the entry iteration order of the original map.
   * Those entries of another [map] that are missing in this map are iterated in the end in the order of that [map].
   */
  KtMap<K, V> operator +(KtMap<K, V> map);

  /**
   * Returns a new read-only map containing all key-value pairs from the original map.
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KtMap<K, V> toMap();

  /**
   * Returns a new mutable map containing all key-value pairs from the original map.
   *
   * The returned map preserves the entry iteration order of the original map.
   */
  KtMutableMap<K, V> toMutableMap();

  /**
   * Performs given [action] on each key/value pair from this map.
   *
   * [action] must not be null.
   */
  void forEach(Function(K key, V value) action);

  /**
   * Returns `true` if there is no entries in the map that match the given [predicate].
   * [predicate] must not be null.
   */
  bool none(Function(K key, V value) predicate);

  /**
   * Returns true if all entries match the given [predicate].
   * [predicate] must not be null.
   */
  bool all(Function(K key, V value) predicate);

  /**
   * Returns true if there is at least one entry that matches the given [predicate].
   * [predicate] must not be null.
   */
  bool any(Function(K key, V value) predicate);
}
