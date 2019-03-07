workflow "CI build" {
  on = "push"
  resolves = [
    "test",
    "validate formatting",
  ]
}

action "pub get" {
  uses = "docker://google/dart:2.2"
  runs = "pub get"
}

action "test" {
  uses = "docker://google/dart:2.2"
  needs = "pub get"
  runs = "pub run test"
}

action "validate formatting" {
  needs = "pub get"
  uses = "docker://google/dart:2.2"
  runs = "pub run tool/reformat.dart"
}