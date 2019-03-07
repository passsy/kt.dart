workflow "build" {
  on = "push"
  resolves = ["pub get"]
}

action "pub get" {
  uses = "docker://google/dart/"
  runs = "pub"
  args = "get"
}
