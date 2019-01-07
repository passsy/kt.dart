import 'dart:collection';

import 'package:dart_kollection/src/collection/set_mutable.dart';
import 'package:dart_kollection/src/k_set_hash.dart';

class DartHashSet<T> extends DartMutableSet<T> implements KHashSet<T> {
  DartHashSet([Iterable<T> iterable = const []])
      : super.noCopy(HashSet.from(iterable));
}
