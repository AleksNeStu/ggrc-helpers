#!/usr/bin/env bash
#set -v
source tools/helper.sh
source tools/app.sh


echo "***Run GGRC (Flask)***"
./stop_ggrc_clean.sh
app_run_ggrc_clean
app_run_ggrc_flask
#set +v