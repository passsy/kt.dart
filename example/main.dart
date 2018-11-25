import 'package:dart_kollection/dart_kollection.dart';

main() {
  final list = listOf(["a", "b", "c"]);
  final emptyL = emptyList();

  final set = setOf(["a", "b", "c"]);
  final emptyS = emptySet();

  final map = mapOf({"a": "A", "b": "B", "c": "C"});
  final emptyM = emptyMap();

  final a = listOf(["a", "b", "c"])
    ..onEach(print)
    ..map((it) => it.toUpperCase()).getOrNull(0);
  print(a); // prints: "A"

  list.map((it) => it.runes.first).filter((it) => it.bitLength < 1).flatMap(_nextChars3).forEach(print);

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
