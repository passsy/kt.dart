#!/bin/sh

pub global activate coverage
pub global activate dart_codecov_generator
pub global run coverage:collect_coverage --port=8111 -o out/coverage/coverage.json --resume-isolates --wait-paused &
dart --observe=8111 test/dart_kollection_test.dart
pub global run coverage:format_coverage --packages=.packages --report-on lib --in out/coverage/coverage.json --out out/coverage/lcov.info --lcov
genhtml -o out/coverage out/coverage/lcov.info