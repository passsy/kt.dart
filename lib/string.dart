import 'package:meta/meta.dart';

extension StringExtension on String {

  /// Returns a copy of this string having its first character replaced with the result of the specified transform, 
  /// or the original string if it's empty.
  /// transform - function that takes the first character and returns the result of the transform applied to the character.
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @experimental
  String replaceFirstChar(String Function(String) transform) {   
    if (isNotEmpty) {
      return transform(this[0]).toString() + substring(1);
    }
    return this;
  }
}