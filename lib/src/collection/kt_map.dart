import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/map.dart";
import "package:kt_dart/src/collection/impl/map_empty.dart";

/// A collection that holds pairs of objects (keys and values) and supports efficiently retrieving
/// the value corresponding to each key. Map keys are unique; the map holds only one value for each key.
/// Methods in this interface support only read-only access to the map; read-write access is supported through
/// the [KtMutableMap] interface.
/// @param K the type of map keys. The map is invariant on its key type, as it
///          can accept key as a parameter (of [containsKey] for example) and return it in [keys] set.
/// @param V the type of map values. The map is covariant on its value type.
abstract class KtMap<K, V> {
  factory KtMap.empty() = EmptyMap<K, V>;

  factory KtMap.from([@nonNull Map<K, V> map = const {}]) {
    assert(() {
      if (map == null) throw ArgumentError("map can't be null");
      return true;
    }());
    if (map.isEmpty) return EmptyMap<K, V>();
    return DartMap(map);
  }

  // Query Operations
  /// Returns the number of key/value pairs in the map.
  int get size;

  /// Access to a `Iterable` to be used in for-loops
  Iterable<KtMapEntry<K, V>> get iter;

  /// Returns a read-only dart:core [Map]
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  ///
  /// - Use [iter] to iterate over the elements of this [KtMap] using a for-loop
  /// - Use [toMap] to copy the map
  Map<K, V> asMap();

  /// Returns `true` if the map is empty (contains no elements), `false` otherwise.
  bool isEmpty();

  /// Returns `true` if the map contains the specified [key].
  bool containsKey(K key);

  /// Returns `true` if the map maps one or more keys to the specified [value].
  bool containsValue(V value);

  /// Returns the value corresponding to the given [key], or `null` if such a key is not present in the map.
  @nullable
  V get(K key);

  /// Returns the value corresponding to the given [key], or `null` if such a key is not present in the map.
  @nullable
  V operator [](K key);

  /// Returns the value corresponding to the given [key], or [defaultValue] if such a key is not present in the map.
  @nullable
  V getOrDefault(K key, V defaultValue);

  // Views
  /// Returns a read-only [KtSet] of all keys in this map.
  KtSet<K> get keys;

  /// Returns a read-only [KtCollection] of all values in this map. Note that this collection may contain duplicate values.
  KtCollection<V> get values;

  /// Returns a read-only [KtSet] of all key/value pairs in this map.
  KtSet<KtMapEntry<K, V>> get entries;
}

/// Represents a key/value pair held by a [KtMap].
abstract class KtMapEntry<K, V> {
  /// Returns the key of this key/value pair.
  K get key;

  /// Returns the value of this key/value pair.
  @nullable
  V get value;

  /// Converts entry to [KtPair] with key being first component and value being second.
  KtPair<K, V> toPair();
}
