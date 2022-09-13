#!/bin/sh
set -e

dart --version
dart pub get
dart pub global activate coverage
(dart pub global list | grep coverage) || {
  # install coverage when not found
  dart pub global activate coverage
}

dart pub global run coverage:collect_coverage \
    --port=8111 \
    --out=out/coverage/coverage.json \
    --wait-paused \
    --resume-isolates \
    &

dart \
    --disable-service-auth-codes \
    --enable-vm-service=8111 \
    --pause-isolates-on-exit  \
    --enable-asserts \
    test/kt_dart_test.dart

TEST_EXIT_CODE=$?
echo "$TEST_EXIT_CODE"

dart pub global run coverage:format_coverage \
    --lcov \
    --in=out/coverage/coverage.json \
    --out=out/coverage/lcov.info \
    --packages=.packages \
    --report-on lib

if type genhtml >/dev/null 2>&1; then
 genhtml -o out/coverage/html out/coverage/lcov.info
 echo "open coverage report $PWD/out/coverage/html/index.html"
else
 echo "genhtml not installed, can't generate html coverage output"
fi

exit $TEST_EXIT_CODE