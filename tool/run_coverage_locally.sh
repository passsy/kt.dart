#!/bin/sh

(pub global list | grep coverage) || {
  # install coverage when not found
  pub global activate coverage
}
pub global run coverage:collect_coverage --port=8111 -o out/coverage/coverage.json --resume-isolates --wait-paused &
dart --observe=8111 --enable-asserts test/kt_dart_test.dart
pub global run coverage:format_coverage --packages=.packages --report-on lib --in out/coverage/coverage.json --out out/coverage/lcov.info --lcov

if type genhtml >/dev/null 2>&1; then
 genhtml -o out/coverage/html out/coverage/lcov.info echo "open coverage report $PWD/out/coverage/html/index.html"
else
 echo "genhtml not installed, can't generate html coverage output"
fi
