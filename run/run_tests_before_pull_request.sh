#!/usr/bin/env bash

#set -v
t=3
dir_pr="ggrc-core"
dir_run="run"

source tools/git.sh
source tools/helper.sh
source tools/app.sh


echo "***Run tests before make pull request***"

#echo "==Stop current virtual envairoment=="
./stop_ggrc.sh

echo "==Create the local git test branch for PR=="
git_create_test_brunch_for_pr

echo "==Run virtual environment and web-app GGRC(Flask)=="
app_run_ggrc_basic
#app_run_ggrc_flask_hidden

echo "==Run tests on the virtual environment side=="
sleep $t
docker exec -i ggrccore_dev_1 su vagrant -c "
    cd /vagrant/bin
    source /vagrant/bin/init_vagrant_env
    echo '=Source code checking='
    echo '-pylint checking-'
    sleep $t
    check_pylint_diff
    echo '-flake8 checking-'
    sleep $t
    check_flake8_diff
    echo '=Unit and integration tests='
    sleep $t
    run_pytests"

echo "==Run tests on the the host side=="
sleep $t
helper_copy_pytest_ini_origin
cd ./../$dir_pr/ ; bin/jenkins/run_selenium
cd ./../$dir_run/
##git stash pop stash@\{0\} ;\
##git stash save --keep-index

echo "==Squashed commit for create patch=="
git_create_squashed_commit

##set +v