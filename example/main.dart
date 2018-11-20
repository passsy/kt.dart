import 'package:dart_kollection/dart_kollection.dart';

main() {
  final list = listOf(["a", "b", "c"]);
  final emptyL = emptyList();

  final set = setOf(["a", "b", "c"]);
  final emptyS = emptySet();

  final map = mapOf({"a": "A", "b": "B", "c": "C"});
  final emptyM = emptyMap();

  list.map((it) => it.runes.first).flatMap((it) => _nextChars(it)).forEach((it) => print(it));

  KMap<String, String> mapping = list.associateWith((key) => ">$key<");
  print(mapping.get("a"));
}

KList<String> _nextChars(int rune) {
  return listOf([
    String.fromCharCode(rune + 1),
    String.fromCharCode(rune + 2),
    String.fromCharCode(rune + 3),
  ]);
}
