#!/usr/bin/env bash

source tools/git.sh

echo "==Git squashed commits to one=="
git_create_squashed_commit
git_commit_all

echo "==Run pylint check=="
docker exec -i ggrccore_dev_1 su vagrant -c "
    cd /vagrant/bin
    source /vagrant/bin/init_vagrant_env
    check_pylint_diff"

echo "==Git squashed commits to one again (to visible check own changes)=="
git_create_squashed_commit

read -p "Press [Enter] to stop..."