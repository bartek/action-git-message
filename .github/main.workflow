workflow "git message quality action" {
  resolves = ["post git quality control"]
  on = "push"
}

action "post git quality control" {
  uses = "bartek/action-git-message@master"
  secrets = ["GITHUB_TOKEN"]
}
