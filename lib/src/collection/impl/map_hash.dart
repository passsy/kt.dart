import 'dart:collection';

import 'package:kotlin_dart/collection.dart';
import 'package:kotlin_dart/src/collection/impl/map_mutable.dart';

class DartHashMap<K, V> extends DartMutableMap<K, V>
    implements KtHashMap<K, V> {
  DartHashMap([Map<K, V> map = const {}]) : super.noCopy(HashMap.from(map));
}
