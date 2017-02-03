#!/usr/bin/env bash

#set -v

source tools/git.sh
source tools/helper.sh
source tools/app.sh

echo "***Run selenium virtual environment for GGRC (selenium_dev, selenium_selenium)***"

echo "==Stop the selenium containers=="
./stop_ggrc.sh

echo "==Run he selenium containers=="
app_run_ggrc_selenium

#set +v