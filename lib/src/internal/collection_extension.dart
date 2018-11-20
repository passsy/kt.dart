import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/list_mutable.dart';

abstract class KCollectionExtensionMixin<T> implements KCollectionExtension<T>, KCollection<T> {
  @override
  int count() => size;

  @override
  KMutableList<T> toMutableList() => DartMutableList<T>(iter);

  @override
  bool isNotEmpty() {}
}
