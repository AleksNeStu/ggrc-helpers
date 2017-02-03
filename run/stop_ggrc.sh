#!/usr/bin/env bash

#set -v

source tools/helper.sh

echo "***Stop GGRC***"
helper_copy_pytest_ini_origin
helper_docker_stop_ggrccore_dev
helper_docker_stop_ggrccore_selenium
helper_docker_stop_selenium_dev
helper_docker_stop_selenium_selenium

#read -p "Press [Enter] to stop..."

#set +v