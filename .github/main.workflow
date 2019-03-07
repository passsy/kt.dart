workflow "build" {
  on = "push"
  resolves = ["pub get"]
}

action "pub get" {
  uses = "docker://google/dart:2.2"
  runs = "pub"
  args = "get"
}
