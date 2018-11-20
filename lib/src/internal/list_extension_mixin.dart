import 'package:dart_kollection/dart_kollection.dart';

abstract class KListExtensionsMixin<T> implements KListExtension<T>, KList<T> {
  int get lastIndex => this.size - 1;

  @override
  T getOrNull(int index) {
    return index >= 0 && index <= lastIndex ? get(index) : null;
  }

  @override
  T elementAt(int index) => get(index);

  @override
  T elementAtOrElse(int index, T defaultValue(int index)) {
    return index >= 0 && index <= lastIndex ? get(index) : defaultValue(index);
  }

  @override
  T elementAtOrNull(int index) => getOrNull(index);
}
