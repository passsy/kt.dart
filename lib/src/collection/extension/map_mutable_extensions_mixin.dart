import "package:kt_dart/collection.dart";

extension KtMutableMapExtensions<K, V> on KtMutableMap<K, V> {
  /// Returns the value for the given key. If the key is not found in the map, calls the [defaultValue] function,
  /// puts its result into the map under the given key and returns it.
  ///
  /// Note that the operation is not guaranteed to be atomic if the map is being modified concurrently.
  @nonNull
  V getOrPut(K key, V Function() defaultValue) {
    assert(() {
      if (defaultValue == null) {
        throw ArgumentError("defaultValue can't be null");
      }
      return true;
    }());
    final value = get(key);
    if (value != null) return value;
    final answer = defaultValue();
    put(key, answer);
    return answer;
  }

  /// Returns an [Iterator] over the entries in the [Map].
  KtMutableIterator<KtMutableMapEntry<K, V>> iterator() => entries.iterator();

  /// Puts all the given [pairs] into this [KtMutableMap] with the first component in the pair being the key and the second the value.
  void putAllPairs(KtIterable<KtPair<K, V>> pairs) {
    assert(() {
      if (pairs == null) throw ArgumentError("pairs can't be null");
      return true;
    }());
    for (final value in pairs.iter) {
      put(value.first, value.second);
    }
  }

  /// If the specified key is not already associated with a value (or is mapped to `null`) associates it with the given value and returns `null`, else returns the current value.
  ///
  ///  return the previous value associated with the specified key, or `null` if there was no mapping for the key. (A `null` return can also indicate that the map previously associated `null` with the key, if the implementation supports `null` values.)
  @nullable
  V putIfAbsent(K key, V value) => get(key) ?? put(key, value);
}
