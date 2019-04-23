import 'package:kt_dart/collection.dart';

abstract class KtMutableMapExtensionsMixin<K, V>
    implements KtMutableMapExtension<K, V>, KtMutableMap<K, V> {
  @override
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

  @override
  KtMutableIterator<KtMutableMapEntry<K, V>> iterator() => entries.iterator();

  @override
  void putAllPairs(KtIterable<KtPair<K, V>> pairs) {
    assert(() {
      if (pairs == null) throw ArgumentError("pairs can't be null");
      return true;
    }());
    for (final value in pairs.iter) {
      put(value.first, value.second);
    }
  }

  @override
  V putIfAbsent(K key, V value) {
    V v = get(key) ?? put(key, value);
    return v;
  }
}
