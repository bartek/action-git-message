workflow "git message quality action" {
    on = "pull_request"
    resolves = ["post git quality control"]
}

action "post git quality control" {
    uses = "bartek/action-git-message@master"
    secrets = ["GITHUB_TOKEN"]
}
