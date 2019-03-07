workflow "CI build" {
  on = "push"
  resolves = [
    "test",
    "validate formatting",
    "codecov"
  ]
}

action "pub get" {
  uses = "docker://google/dart:2.2"
  runs = "pub get"
}

action "test" {
  uses = "docker://google/dart:2.2"
  needs = "pub get"
  runs = "./ci/test.sh"
}

action "validate formatting" {
  needs = "pub get"
  uses = "docker://google/dart:2.2"
  runs = "pub run tool/reformat.dart"
}

action "codecov" {
  uses = "docker://bash:5.0"
  needs = "test"
  runs = "bash <(curl -s https://codecov.io/bash)"
}