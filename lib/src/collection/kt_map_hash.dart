import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/map_hash.dart";

abstract class KtHashMap<K, V> implements KtMutableMap<K, V> {
  factory KtHashMap.empty() => DartHashMap<K, V>();

  factory KtHashMap.from([Map<K, V> map = const {}]) {
    return DartHashMap(map);
  }
}
