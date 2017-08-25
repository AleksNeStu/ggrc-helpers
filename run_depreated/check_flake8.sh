#!/usr/bin/env bash
source tools/git.sh


git_commit_last
echo "Run flake8 checks"
docker exec -i ggrccore_dev_1 su vagrant -c "
    cd /vagrant/bin
    source /vagrant/bin/init_vagrant_env
    check_flake8_diff"
git_uncommit_last
#echo "Press [Enter] to stop..."
#read -p "Press [Enter] to stop..."