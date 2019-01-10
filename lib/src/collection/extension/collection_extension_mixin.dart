import 'dart:math' as math show Random;

import 'package:kt_dart/collection.dart';

abstract class KtCollectionExtensionMixin<T>
    implements KCollectionExtension<T>, KtCollection<T> {
  @override
  KtMutableList<T> toMutableList() => KtMutableList<T>.from(iter);

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
      transform: (it) =>
          identical(it, this) ? "(this Collection)" : it.toString(),
    );
  }
}
