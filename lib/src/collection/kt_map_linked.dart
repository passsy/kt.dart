import 'package:kt_stdlib/collection.dart';
import 'package:kt_stdlib/src/collection/impl/map_linked.dart';

abstract class KtLinkedMap<K, V> implements KtMutableMap<K, V> {
  factory KtLinkedMap.empty() => DartLinkedHashMap<K, V>();

  factory KtLinkedMap.from([Map<K, V> map = const {}]) =>
      DartLinkedHashMap(map);
}
