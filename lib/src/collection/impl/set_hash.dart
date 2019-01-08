import 'dart:collection';

import 'package:kt_stdlib/src/collection/impl/set_mutable.dart';
import 'package:kt_stdlib/src/collection/kt_set_hash.dart';

class DartHashSet<T> extends DartMutableSet<T> implements KtHashSet<T> {
  DartHashSet([Iterable<T> iterable = const []])
      : super.noCopy(HashSet.from(iterable));
}
