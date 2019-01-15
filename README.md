Git Message Quality Action
------------------------

Built for an exercise as part of my [article on GitHub Actions](WIP)

# Usage

```
workflow "git message quality action" {
    on = "pull_request"
    resolves = ["post git quality control"]
}

action "post git quality control" {
    uses = "bartek/action-git-message@master"
    secrets = ["GITHUB_TOKEN"]
}
```

# Tests

```
$ make test
```
