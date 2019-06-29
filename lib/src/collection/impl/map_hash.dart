import "dart:collection";

import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/map_mutable.dart";

class DartHashMap<K, V> extends DartMutableMap<K, V>
    implements KtHashMap<K, V> {
  DartHashMap([Map<K, V> map = const {}]) : super.noCopy(HashMap.from(map));
}
