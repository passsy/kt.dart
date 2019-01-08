import 'dart:collection';

import 'package:kt_stdlib/src/collection/impl/map_mutable.dart';
import 'package:kt_stdlib/src/collection/kt_map_linked.dart';

class DartLinkedHashMap<K, V> extends DartMutableMap<K, V>
    implements KtLinkedMap<K, V> {
  DartLinkedHashMap([Map<K, V> map = const {}])
      : super.noCopy(LinkedHashMap.from(map));
}
