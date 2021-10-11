import 'package:meta/meta.dart';

extension StringExtension on String {

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