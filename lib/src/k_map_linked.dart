import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/map_hash.dart';
import 'package:dart_kollection/src/collection/map_linked.dart';

abstract class KLinkedMap<K, V> implements KMutableMap<K, V> {
  factory KLinkedMap.empty() => DartLinkedHashMap<K, V>();

  factory KLinkedMap.from([Map<K, V> map = const {}]) => DartLinkedHashMap(map);
}
