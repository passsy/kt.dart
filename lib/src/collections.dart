import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/internal/list.dart';
import 'package:dart_kollection/src/internal/list_empty.dart';

KList<T> listOf<T>([Iterable<T> elements = const []]) {
  if (elements.length == 0) return emptyList();
  return DartList(elements);
}

// ignore: unnecessary_cast
KList<T> emptyList<T>() => kEmptyList as KList<Object>;
