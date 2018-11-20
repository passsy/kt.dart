import 'package:dart_kollection/dart_kollection.dart';

abstract class KListExtensionsMixin<T> implements KListExtension<T>, KList<T> {
  int get lastIndex => this.size - 1;

  T getOrNull(int index) {
    return index >= 0 && index <= lastIndex ? get(index) : null;
  }

  T elementAt(int index) => get(index);

  T elementAtOrElse(int index, T defaultValue(int index)) {
    return index >= 0 && index <= lastIndex ? get(index) : defaultValue(index);
  }

  T elementAtOrNull(int index) => getOrNull(index);
}
