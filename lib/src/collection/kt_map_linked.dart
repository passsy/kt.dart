import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/impl/map_linked.dart';

abstract class KtLinkedMap<K, V> implements KtMutableMap<K, V> {
  factory KtLinkedMap.empty() => DartLinkedHashMap<K, V>();

  factory KtLinkedMap.from([@nonNull Map<K, V> map = const {}]) {
    assert(() {
      if (map == null) throw ArgumentError("map can't be null");
      return true;
    }());
    return DartLinkedHashMap(map);
  }
}
