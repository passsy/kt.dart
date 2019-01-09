import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/map_hash.dart';

@Deprecated(
    "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
abstract class KHashMap<K, V> implements KMutableMap<K, V> {
  @Deprecated(
      "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
  factory KHashMap.empty() => DartHashMap<K, V>();

  @Deprecated(
      "Please migrate to kotlin.dart https://github.com/passsy/kotlin.dart")
  factory KHashMap.from([Map<K, V> map = const {}]) => DartHashMap(map);
}
