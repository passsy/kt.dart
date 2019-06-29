import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/map_hash.dart";

abstract class KtHashMap<K, V> implements KtMutableMap<K, V> {
  factory KtHashMap.empty() => DartHashMap<K, V>();

  factory KtHashMap.from([@nonNull Map<K, V> map = const {}]) {
    assert(() {
      if (map == null) throw ArgumentError("map can't be null");
      return true;
    }());
    return DartHashMap(map);
  }
}
