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
    var mid = size >> 1;

    var i = 0;
    var j = size - 1;
    while (i < mid) {
      swap(i, j);
      i++;
      j--;
    }
  }

  @override
  void swap(int indexA, int indexB) {
    var firstOld = get(indexA);
    var secondOld = set(indexB, firstOld);
    set(indexA, secondOld);
  }
}
