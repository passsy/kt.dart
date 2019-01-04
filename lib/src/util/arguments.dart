/// Creates a [List] based on the parameters, ignores `null` at the end, throws for `null` between elements.
///
/// argsToList(1, 2, 3) => [1, 2, 3]
/// argsToList(1, 2, 3, null, null) => [1, 2, 3]
/// argsToList(1, 2, null, 3) => throws ArgumentError("Element at position 2 is null.")
///
///
List<T> argsToList<T>(
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
  List<T> args;
  if (arg9 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9];
  } else if (arg8 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8];
  } else if (arg7 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7];
  } else if (arg6 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5, arg6];
  } else if (arg5 != null) {
    args = [arg0, arg1, arg2, arg3, arg4, arg5];
  } else if (arg4 != null) {
    args = [arg0, arg1, arg2, arg3, arg4];
  } else if (arg3 != null) {
    args = [arg0, arg1, arg2, arg3];
  } else if (arg2 != null) {
    args = [arg0, arg1, arg2];
  } else if (arg1 != null) {
    args = [arg0, arg1];
  } else if (arg0 != null) {
    return [arg0];
  } else {
    return [];
  }

  if (args.contains(null))
    throw ArgumentError("Element at position ${args.indexOf(null)} is null.");
  return args;
}
