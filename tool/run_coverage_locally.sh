#!/bin/sh

(pub global list | grep coverage) || {
  # install coverage when not found
  pub global activate coverage
}
pub global run coverage:collect_coverage --port=8111 -o out/coverage/coverage.json --resume-isolates --wait-paused &
dart --observe=8111 --enable-asserts test/dart_kollection_test.dart
pub global run coverage:format_coverage --packages=.packages --report-on lib --in out/coverage/coverage.json --out out/coverage/lcov.info --lcov
genhtml -o out/coverage/html out/coverage/lcov.info
echo "open coverage report $PWD/out/coverage/html/index.html"