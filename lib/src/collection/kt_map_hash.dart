import 'package:kotlin_dart/collection.dart';
import 'package:kotlin_dart/src/collection/impl/map_hash.dart';

@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
abstract class KtHashMap<K, V> implements KtMutableMap<K, V> {
  @Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
  factory KtHashMap.empty() => DartHashMap<K, V>();

  @Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
  factory KtHashMap.from([Map<K, V> map = const {}]) => DartHashMap(map);
}
