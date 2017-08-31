#!/usr/bin/env bash
#set -v &&\
t=1 # timeout
dir_pr="ggrc-core"
dir_run="run"

app_run_ggrc_clean () {
echo "Run containers: ggrc-cleandev, ggrc-db"
sleep $t
# to recreate containers need run: "docker-compose up -d --force-recreate"
cd ./../$dir_pr/
bin/containers setup dev
docker ps | grep ggrccore
cd ./../$dir_run/
echo "Set aliases for start interactive bash sessions on containers"
sleep $t
alias clandev="docker exec -it ggrccore_cleandev_1 su"
cat << EOF
alias dev="docker exec -it ggrccore_cleandev_1 su"
EOF
echo "Run GGRC web-app"
sleep $t

}

app_run_ggrc_flask () {
docker exec -i ggrccore_cleandev_1 su -c "
   cd /vagrant/bin
   source /vagrant/bin/init_vagrant_env
   echo '-launch ggrc-'
   sleep $t
   launch_ggrc"
}

app_rerun_ggrc_flask () {
docker exec -i ggrccore_cleandev_1 su -c "
   cd /vagrant/bin
   source /vagrant/bin/init_vagrant_env
   make bower_components
   build_css
   build_assets
   db_reset
   launch_ggrc
"
}

app_run_ggrc_flask_hidden () {
screen -dmSU flask_hidden $(
docker exec -i ggrccore_cleandev_1 su -c "
   cd /vagrant/bin
   source /vagrant/bin/init_vagrant_env
   echo '-launch ggrc-'
   sleep $t
   launch_ggrc")
}

app_run_ggrc_gae () {
docker exec -i ggrccore_cleandev_1 su -c "
   cd /vagrant/bin
   source /vagrant/bin/init_vagrant_env
   echo '-launch ggrc_gae-'
   sleep $t
   deploy_appengine extras/deploy_settings_local.sh
   make appengine_packages_zip
   launch_gae_ggrc"
}