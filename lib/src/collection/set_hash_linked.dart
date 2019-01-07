import 'dart:collection';

import 'package:dart_kollection/src/collection/set_mutable.dart';
import 'package:dart_kollection/src/k_set_linked.dart';

class DartLinkedSet<T> extends DartMutableSet<T> implements KLinkedSet<T> {
  DartLinkedSet([Iterable<T> iterable = const []])
      : super.noCopy(LinkedHashSet.from(iterable));
}
