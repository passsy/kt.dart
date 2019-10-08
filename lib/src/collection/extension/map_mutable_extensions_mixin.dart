import "package:kt_dart/collection.dart";

extension KtMutableMapExtensions<K, V> on KtMutableMap<K, V> {
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

  KtMutableIterator<KtMutableMapEntry<K, V>> iterator() => entries.iterator();

  void putAllPairs(KtIterable<KtPair<K, V>> pairs) {
    assert(() {
      if (pairs == null) throw ArgumentError("pairs can't be null");
      return true;
    }());
    for (final value in pairs.iter) {
      put(value.first, value.second);
    }
  }

  V putIfAbsent(K key, V value) => get(key) ?? put(key, value);
}
