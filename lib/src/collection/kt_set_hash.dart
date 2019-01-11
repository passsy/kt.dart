import 'package:kotlin_dart/collection.dart';
import 'package:kotlin_dart/src/collection/impl/set_hash.dart';
import 'package:kotlin_dart/src/util/arguments.dart';

@Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
abstract class KtHashSet<T> implements KtMutableSet<T> {
  @Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
  factory KtHashSet.empty() => KtHashSet.from();

  @Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
  factory KtHashSet.from([Iterable<T> elements = const []]) {
    return DartHashSet<T>(elements);
  }

  @Deprecated("Please migrate to kt.dart https://github.com/passsy/kt.dart")
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
      T arg9]) {
    final args =
        argsToList(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    return KtHashSet.from(args);
  }
}
