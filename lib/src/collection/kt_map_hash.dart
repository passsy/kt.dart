import 'package:kt_stdlib/collection.dart';
import 'package:kt_stdlib/src/collection/impl/map_hash.dart';

abstract class KtHashMap<K, V> implements KtMutableMap<K, V> {
  factory KtHashMap.empty() => DartHashMap<K, V>();

  factory KtHashMap.from([Map<K, V> map = const {}]) => DartHashMap(map);
}
