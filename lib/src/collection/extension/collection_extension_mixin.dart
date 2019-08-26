import "dart:math" as math show Random;

import "package:kt_dart/collection.dart";

extension KtCollectionExtensions<T> on KtCollection<T> {
  KtMutableList<T> toMutableList() => KtMutableList<T>.from(iter);

  bool isNotEmpty() => size > 0;

  T random([math.Random random]) {
    final r = random ?? math.Random();
    return elementAt(r.nextInt(size));
  }

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
