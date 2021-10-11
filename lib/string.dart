import 'package:meta/meta.dart';

extension StringExtension on String {

  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @experimental
  String replaceFirstChar(String Function() transform) {   
    if (isNotEmpty) {
      return transform();
    }

    return this;
  }
  

  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @experimental
  String uppercase() {
      return "${this[0].toUpperCase()}${substring(1)}";
  }

  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @experimental
  String lowercase() {
      return "${this[0].toLowerCase()}${substring(1)}";
  }
}