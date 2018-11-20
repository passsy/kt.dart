import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/map_extensions.dart';
import 'package:dart_kollection/src/k_map_mutable.dart';

abstract class KMutableMapExtensionsMixin<K, V> implements KMutableMapExtension<K, V>, KMutableMap<K, V> {
  void putAllPairs(KIterable<KPair<K, V>> pairs) {
    for (var value in pairs.iter) {
      put(value.first, value.second);
    }
  }
}
