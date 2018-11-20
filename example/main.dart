import 'package:dart_kollection/dart_kollection.dart';

main() {
  final list = listOf(["a", "b", "c"]);
  final emptyL = emptyList();

  final set = setOf(["a", "b", "c"]);
  final emptyS = emptySet();

  final map = mapOf({"a": "A", "b": "B", "c": "C"});
  final emptyM = emptyMap();

  list.map((it) => it.runes.first).flatMap(_nextChars3).forEach(print);

  KMap<String, String> mapping = list.associateWith((key) => ">$key<");
  print(mapping.get("a"));
}

KList<String> _nextChars3(int rune) {
  return listOf([
    String.fromCharCode(rune + 1),
    String.fromCharCode(rune + 2),
    String.fromCharCode(rune + 3),
  ]);
}
