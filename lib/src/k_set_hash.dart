import 'package:dart_kollection/dart_kollection.dart';
import 'package:dart_kollection/src/collection/set_hash.dart';
import 'package:dart_kollection/src/util/arguments.dart';

abstract class KHashSet<T> implements KMutableSet<T> {
  factory KHashSet.empty() => KHashSet.from();

  factory KHashSet.from([Iterable<T> elements = const []]) {
    return DartHashSet<T>(elements);
  }

  factory KHashSet.of(
      [T arg0,
      T arg1,
      T arg2,
      T arg3,
      T arg4,
      T arg5,
      T arg6,
      T arg7,
      T arg8,
      T arg9]) {
    final args =
        argsToList(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    return KHashSet.from(args);
  }
}
