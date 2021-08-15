import "dart:async";
import "dart:io";

Future<void> main(List<String> args) async {
  stdout.writeln("Reformatting project with dartfmt");
  final Process dartfmt = await Process.start(
      "dart", ["format", "--set-exit-if-changed", "--fix", "."]);

  // ignore: unawaited_futures
  stderr.addStream(dartfmt.stderr);
  // ignore: unawaited_futures
  stdout.addStream(dartfmt.stdout
      // help dartfmt formatting
      .map((it) => String.fromCharCodes(it))
      .where((it) => !it.contains("Unchanged"))
      .map(reformatDartfmtStdout)
      .map((it) => it.codeUnits));

  final reformatExit = await dartfmt.exitCode;

  stdout.writeln();
  if (reformatExit == 0) {
    stdout.writeln("All files are correctly formatted");
  } else {
    stdout.writeln("Error: Some files require reformatting with dartfmt");
    stdout.writeln("run: ./flutterw packages pub run tool/reformat.dart");
  }
  exit(reformatExit);
}

String reformatDartfmtStdout(String line) {
  if (line.startsWith("Formatting directory")) {
    return line.replaceFirst("Formatting directory ", "");
  }
  return "- $line";
}
