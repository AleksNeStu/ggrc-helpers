#!/usr/bin/env bash
#set -v &&\


t=3 # timeout
dir_project="ggrc-core"
dir_run="run"
rel_branch="release/0.10-Raspberry"
dev_branch="develop"
pr_branch="origin/test_update_snapshotable_control" # PR branch

BRANCH () {
echo $(git branch | grep \* | cut -d ' ' -f2)
}

git_uncommit_last () {
cd ./../$dir_project/
git reset --soft HEAD^
cd ./../$dir_run/
}

git_commit_last () {
cd ./../$dir_project/
git add -A && git commit -m "temp"
cd ./../$dir_run/
}