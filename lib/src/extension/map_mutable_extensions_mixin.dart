import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/k_map_mutable.dart';

abstract class KMutableMapExtensionsMixin<K, V> implements KMutableMapExtension<K, V>, KMutableMap<K, V> {
  @override
  V getOrPut(K key, V Function() defaultValue) {
    final value = get(key);
    if (value != null) return value;
    final answer = defaultValue();
    put(key, answer);
    return answer;
  }

  KMutableIterator<KMutableMapEntry<K, V>> iterator() => entries.iterator();

  @override
  void putAllPairs(KIterable<KPair<K, V>> pairs) {
    for (var value in pairs.iter) {
      put(value.first, value.second);
    }
  }

  @override
  V putIfAbsent(K key, V value) {
    V v = get(key);
    if (v == null) {
      v = put(key, value);
    }
    return v;
  }
}
