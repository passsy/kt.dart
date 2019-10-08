import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/map_mutable.dart";

/// A modifiable collection that holds pairs of objects (keys and values) and supports efficiently retrieving
/// the value corresponding to each key. Map keys are unique; the map holds only one value for each key.
/// @param K the type of map keys. The map is invariant on its key type.
/// @param V the type of map values. The mutable map is invariant on its value type.
abstract class KtMutableMap<K, V> implements KtMap<K, V> {
  factory KtMutableMap.empty() => DartMutableMap<K, V>();

  factory KtMutableMap.from([@nonNull Map<K, V> map = const {}]) {
    assert(() {
      if (map == null) throw ArgumentError("map can't be null");
      return true;
    }());
    return DartMutableMap(map);
  }

  /// Creates a [Map] instance that wraps the original [KtMap]. It acts as a view.
  ///
  /// Mutations on the returned [Map] are reflected on the original [KtMap]
  /// and vice versa.
  ///
  /// This method can be used to interop between the dart:collection and the
  /// kt.dart world.
  ///
  /// - Use [iter] to iterate over the elements of this [KtMap] using a for-loop
  /// - Use [toMap] to copy the map
  @override
  Map<K, V> asMap();

  // Modification Operations
  /// Associates the specified [value] with the specified [key] in the map.
  ///
  /// @return the previous value associated with the key, or `null` if the key was not present in the map.
  @nullable
  V put(K key, V value);

  /// Associates the specified [value] with the specified [key] in the map.
  void operator []=(K key, V value);

  /// Removes the specified key and its corresponding value from this map.
  ///
  /// @return the previous value associated with the key, or `null` if the key was not present in the map.
  @nullable
  V remove(K key);

  /// Removes the entry for the specified key only if it is mapped to the specified value.
  ///
  /// @return true if entry was removed
  bool removeMapping(K key, V value);

  // Bulk Modification Operations
  /// Updates this map with key/value pairs from the specified map [from].
  void putAll(KtMap<K, V> from);

  /// Removes all elements from this map.
  void clear();

  // Views

  /// Returns a [KtMutableSet] of all keys in this map.
  @override
  KtMutableSet<K> get keys;

  /// Returns a [KtMutableCollection] of all values in this map. Note that this collection may contain duplicate values.
  @override
  KtMutableCollection<V> get values;

  /// Returns a [KtMutableSet] of all key/value pairs in this map.
  @override
  KtMutableSet<KtMutableMapEntry<K, V>> get entries;
}

/// Represents a key/value pair held by a [KtMutableMap].
abstract class KtMutableMapEntry<K, V> extends KtMapEntry<K, V> {
  /// Changes the value associated with the key of this entry.
  ///
  /// @return the previous value corresponding to the key.
  @nullable
  V setValue(V newValue);
}
