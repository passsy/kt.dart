import 'dart:collection';

import 'package:kt_stdlib/src/collection/impl/set_mutable.dart';
import 'package:kt_stdlib/src/collection/kt_set_linked.dart';

class DartLinkedSet<T> extends DartMutableSet<T> implements KtLinkedSet<T> {
  DartLinkedSet([Iterable<T> iterable = const []])
      : super.noCopy(LinkedHashSet.from(iterable));
}
