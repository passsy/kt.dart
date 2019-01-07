import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/map_hash.dart';

abstract class KHashMap<K, V> implements KMutableMap<K, V> {
  factory KHashMap.empty() => DartHashMap<K, V>();

  factory KHashMap.from([Map<K, V> map = const {}]) => DartHashMap(map);
}
