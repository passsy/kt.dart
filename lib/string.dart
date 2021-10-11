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
      return transform(this);
    }

    return this;
  }
  

  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @experimental
  String toUpperCase() {
      return "${this[0].toUpperCase()}${substring(1)}";
  }

  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @experimental
  String toLowerCase() {
      return "${this[0].toLowerCase()}${substring(1)}";
  }
}