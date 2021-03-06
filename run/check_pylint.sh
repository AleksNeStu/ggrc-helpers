#!/usr/bin/env bash
source tools/git.sh


git_commit_last
echo "Run pylint checks"
docker exec -i ggrccore_cleandev_1 su -c "
    cd /vagrant/bin
    source /vagrant/bin/init_vagrant_env
    check_pylint_diff"
git_uncommit_last
#read -p "Press [Enter] to stop..."