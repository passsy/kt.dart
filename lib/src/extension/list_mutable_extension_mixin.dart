import 'package:dart_kollection/dart_kollection.dart';

abstract class KMutableListExtensionsMixin<T> implements KMutableListExtension<T>, KMutableList<T> {
  @override
  void fill(T value) {
    for (var i = 0; i < size; i++) {
      set(i, value);
    }
  }

  @override
  void reverse() {
    final fwd = listIterator(0);
    final rev = listIterator(size);
    var mid = size >> 1;

    var i = 0;
    while (i < mid) {
      i++;
      final tmp = fwd.next();
      fwd.set(rev.previous());
      rev.set(tmp);
    }
  }
}
