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

git_submodules_update () {
echo "Cit update submodules 'CSS/Javascript asset dependencies'"
sleep $t
cd ./../$dir_project/
git submodule update --init
git submodule update
cd ./../$dir_run/
}

git_pull_from_remote () {
echo "Git checkout to origin: $1 and pull from upstream: $1"
sleep $t
cd ./../$dir_project/
git checkout $1
git fetch upstream $1
git pull upstream $1
REV=$(git rev-parse HEAD)
REV_DATA=$(git show -s --format=%ci $REV)
REV_AUTHOR=$(git --no-pager show -s --format='%an <%ae>' $REV)
BRANCH
echo "Pull status: rev = "$REV" | data = "$REV_DATA" | author = "$REV_AUTHOR
}

git_uncommit_last () {
cd ./../$dir_project/
git reset --soft HEAD^
cd ./../$dir_run/
}

git_commit_last () {
cd ./../$dir_project/
git add -A && git commit -m "AleksNeStu"
cd ./../$dir_run/
}

git_create_squashed_commit () {
cd ./../$dir_project/
COMMITS=$(git rev-list --count HEAD ^$pr_branch)
git reset --soft HEAD~$COMMITS
cd ./../$dir_run/
}

git_create_squashed_commit_and_comment () {
cd ./../$dir_project/
COMMITS=$(git rev-list --count HEAD ^$pr_branch)
git reset --soft HEAD~$COMMITS
git commit --quiet -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
cd ./../$dir_run/
}

git_commit_all () {
cd ./../$dir_project/
git add -A && git commit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
cd ./../$dir_run/
}

git_update_fork () {
cd ./../$dir_project/
git_pull_from_remote $dev_branch
git push -f origin $dev_branch
git_pull_from_remote $rel_branch
git push -f origin $rel_branch
cd ./../$dir_run/
}
#set +v