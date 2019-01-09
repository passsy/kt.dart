import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/map_linked.dart';

@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
abstract class KLinkedMap<K, V> implements KMutableMap<K, V> {
  @Deprecated(
      "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
  factory KLinkedMap.empty() => DartLinkedHashMap<K, V>();

  @Deprecated(
      "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
  factory KLinkedMap.from([Map<K, V> map = const {}]) => DartLinkedHashMap(map);
}
