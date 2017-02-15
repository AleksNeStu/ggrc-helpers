#!/usr/bin/env bash
source tools/git.sh

echo "Git squashed commits to one"
git_create_squashed_commit
git_commit_all

echo "Run integration check"
docker exec -i ggrccore_dev_1 su vagrant -c "
    cd /vagrant/bin
    source /vagrant/bin/init_vagrant_env
    run_pytests"

read -p "Press [Enter] to stop..."