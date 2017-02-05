#!/usr/bin/env bash

#set -v &&\
t=3 # timeout
dir_pr="ggrc-core"
dir_run="run"

git_run_submodules_update () {
cd ./../$dir_pr/
git submodule update --init
git submodule update
cd ./../$dir_run/
}

git_run_pull_rebase () {
echo "=Git chekout to local dev brunch and pull from remote repo="
sleep $t
cd ./../$dir_pr/
BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
#cd $(find ggrc-core -maxdepth 0 -type d \( ! -name . \) -exec bash -c "cd '{}' && pwd" \;) ; pwd ;\
git checkout develop
git status
git pull origin develop
REV=$(git rev-parse HEAD)
REV_DATA=$(git show -s --format=%ci $REV)
REV_AUTHOR=$(git --no-pager show -s --format='%an <%ae>' $REV)
echo "Last dev revision number: "$REV" | data: "$REV_DATA" | author: "$REV_AUTHOR
echo "=Cit update submodules "CSS/Javascript asset dependencies"="
sleep $t
# ./ggrc-core/src/ggrc/assets/vendor/bootstrap-sass
git submodule update --init
git submodule update
echo "=Git chekout to "$BRANCH" local brunch and rebase from local dev brunch="
sleep $t
git checkout $BRANCH
git rebase release/0.9.7-Quince
REV_N=$(git rev-parse HEAD)
REV_DATA_N=$(git show -s --format=%ci $REV_N)
REV_AUTHOR_N=$(git --no-pager show -s --format='%an <%ae>' $REV_N)
echo "Last branch revision number: "$REV_N" | data: "$REV_DATA_N" | author: "$REV_AUTHOR_N

cd ./../$dir_run/
}

git_get_last_rev_from_dev () {
cd ./../$dir_pr/
BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
git checkout release/0.9.7-Quince
REV=$(git rev-parse HEAD) #get last revision number for checking code spelling
DATA=$(git show -s --format=%ci $REV)
git checkout $BRANCH
cd ./../$dir_run/
}

git_create_test_brunch_for_pr () {
cd ./../$dir_pr/
BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
if grep -qv "_for_PR" <<< $BRANCH
then
echo "-Delete existing local branches with '_for_PR'-"
git branch -D $(git branch --list | grep $BRANCH | grep "_for_PR")
echo "-Create local branch "$BRANCH"_for_PR -"
git checkout -b $BRANCH"_for_PR"
echo "Squash the last patch's commits and write united commit message"
COMMITS=$(git rev-list --count HEAD ^release/0.9.7-Quince)
git reset --soft HEAD~$COMMITS &&
git commit --quiet -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
else
echo ERROR: "Current branch title already for tests before PR"
exit 1
fi
cd ./../$dir_run/
}

git_create_squashed_commit () {
cd ./../$dir_pr/
BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
echo "Squashed the last patch's commits for branch : "$BRANCH
COMMITS=$(git rev-list --count HEAD ^sr/create-from-audit)
git reset --soft HEAD~$COMMITS
}
cd ./../$dir_run/

git_create_squashed_commit_and_comment () {
cd ./../$dir_pr/
BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
echo "Squashed the last patch's commits for branch : "$BRANCH
COMMITS=$(git rev-list --count HEAD ^sr/create-from-audit)
git reset --soft HEAD~$COMMITS
git commit --quiet -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
}
cd ./../$dir_run/

git_commit_all () {
cd ./../$dir_pr/
BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
echo "Commit all and comment: "$BRANCH
git add -A && git commit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
}
cd ./../$dir_run/

git_update_fork () {
cd ./../$dir_pr/
BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
echo "Current branch: "$BRANCH
#git remote add upstream https://github.com/google/ggrc-core.git
git fetch upstream
git checkout develop
git rebase upstream/develop
git push -f origin develop
}
cd ./../$dir_run/

#set +v