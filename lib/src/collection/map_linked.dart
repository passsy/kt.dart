import 'dart:collection';

import 'package:dart_kollection/src/collection/map_mutable.dart';
import 'package:dart_kollection/src/k_map_linked.dart';

class DartLinkedHashMap<K, V> extends DartMutableMap<K, V>
    implements KLinkedMap<K, V> {
  DartLinkedHashMap([Map<K, V> map = const {}])
      : super.noCopy(LinkedHashMap.from(map));
}
