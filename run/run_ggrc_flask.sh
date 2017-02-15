#!/usr/bin/env bash
#set -v
source tools/git.sh
source tools/helper.sh
source tools/app.sh


echo "***Run virtual environment and web-app GGRC(Flask)***"
echo "Stop instance of web-app"
./stop_ggrc.sh
echo "Resolution check"
helper_check_resolution
echo "Git pull and rebase"
git_submodules_update
echo "Replacements"
helper_copy_pytest_ini
echo "==Docker containers & web-app=="
app_run_ggrc_basic
app_run_ggrc_flask
#set +v