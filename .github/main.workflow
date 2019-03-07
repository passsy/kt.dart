workflow "build" {
  on = "push"
  resolves = ["docker://passsy/flutterw"]
}

action "docker://passsy/flutterw" {
  uses = "docker://passsy/flutterw"
  runs = "./flutterw"
  args = "build"
}
