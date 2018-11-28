import 'dart:math' as math;

import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/list_mutable.dart';

abstract class KCollectionExtensionMixin<T> implements KCollectionExtension<T>, KCollection<T> {
  @override
  KMutableList<T> toMutableList() => DartMutableList<T>(iter);

  @override
  bool isNotEmpty() => size > 0;

  @override
  T random([math.Random random]) {
    final r = random ?? math.Random();
    return elementAt(r.nextInt(size));
  }

  @override
  String toString() {
    return joinToString(
        separator: ", ",
        prefix: "[",
        postfix: "]",
        transform: (it) => (identical(it, this) ? "(this Collection)" : it.toString()));
  }
}
