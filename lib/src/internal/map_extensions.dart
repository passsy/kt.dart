import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/k_map_mutable.dart';

abstract class KMapExtensionsMixin<K, V> implements KMapExtension<K, V>, KMap<K, V> {
  @override
  M mapKeysTo<R, M extends KMutableMap<R, V>>(M destination, R Function(KMapEntry<K, V> entry) transform) {
    return entries.associateByTo(destination, transform, (it) => it.value);
  }
}
