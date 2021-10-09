extension StringExtension on String {

  String replaceFirstChar(String Function() transform) {    
    if (this == null || this == '') {
      return this;
    }
    return transform();
  }

  String capitalize() {
      return "${this[0].toUpperCase()}${substring(1)}";
  }

  String lowercase() {
      return "${this[0].toLowerCase()}${substring(1)}";
  }
}