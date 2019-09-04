import "package:kt_dart/collection.dart";
import "package:kt_dart/src/collection/impl/set_hash.dart";
import "package:kt_dart/src/util/arguments.dart";

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
      [T? arg0,
      T? arg1,
      T? arg2,
      T? arg3,
      T? arg4,
      T? arg5,
      T? arg6,
      T? arg7,
      T? arg8,
      T? arg9]) {
    final args =
        argsToList(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    return KtHashSet.from(args);
  }
}
