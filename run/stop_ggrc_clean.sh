#!/usr/bin/env bash
#set -v
source tools/helper.sh


echo "***Stop GGRC***"
helper_docker_stop_ggrccore_cleandev
helper_docker_stop_ggrccore_db
#read -p "Press [Enter] to stop..."
#set +v