import 'dart:collection';

import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/map_mutable.dart';

class DartHashMap<K, V> extends DartMutableMap<K, V> implements KHashMap<K, V> {
  DartHashMap([Map<K, V> map = const {}]) : super.noCopy(HashMap.from(map));
}
