import "package:kt_dart/annotation.dart";

extension IntRangeExtension on int {
  @experimental
  Iterable<int> rangeTo(int end) sync* {
    if (this < end) {
      for (int i = this; i <= end; i++) {
        yield i;
      }
    } else {
      for (int i = this; i >= 0; i--) {
        yield i;
      }
    }
  }
}
