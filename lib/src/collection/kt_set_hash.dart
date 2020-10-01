import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/impl/set_hash.dart';
import 'package:kt_dart/src/util/arguments.dart';

abstract class KtHashSet<T> implements KtMutableSet<T> {
  factory KtHashSet.empty() => KtHashSet.from();

  factory KtHashSet.from([@nonNull Iterable<T> elements = const []]) {
    assert(() {
      if (elements == null) throw ArgumentError("elements can't be null");
      return true;
    }());
    return DartHashSet<T>(elements);
  }

  factory KtHashSet.of(
      [T arg0,
      T arg1,
      T arg2,
      T arg3,
      T arg4,
      T arg5,
      T arg6,
      T arg7,
      T arg8,
      T arg9]) = KtHashSet<T>._of;

  factory KtHashSet._of([
    Object arg0 = defaultArgument,
    Object arg1 = defaultArgument,
    Object arg2 = defaultArgument,
    Object arg3 = defaultArgument,
    Object arg4 = defaultArgument,
    Object arg5 = defaultArgument,
    Object arg6 = defaultArgument,
    Object arg7 = defaultArgument,
    Object arg8 = defaultArgument,
    Object arg9 = defaultArgument,
  ]) {
    return KtHashSet.from([
      if (arg0 != defaultArgument) arg0 as T,
      if (arg1 != defaultArgument) arg1 as T,
      if (arg2 != defaultArgument) arg2 as T,
      if (arg3 != defaultArgument) arg3 as T,
      if (arg4 != defaultArgument) arg4 as T,
      if (arg5 != defaultArgument) arg5 as T,
      if (arg6 != defaultArgument) arg6 as T,
      if (arg7 != defaultArgument) arg7 as T,
      if (arg8 != defaultArgument) arg8 as T,
      if (arg9 != defaultArgument) arg9 as T,
    ]);
  }
}
