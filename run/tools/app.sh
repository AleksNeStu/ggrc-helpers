#!/usr/bin/env bash
#set -v &&\
t=1 # timeout
dir_pr="ggrc-core"
dir_run="run"

app_run_ggrc_basic () {
echo "Run containers: ggrc-dev, ggrc-selenium"
sleep $t
# to recreate containers need run: "docker-compose up -d --force-recreate"
cd ./../$dir_pr/
docker-compose up -d --force-recreate
docker ps | grep ggrccore
cd ./../$dir_run/
echo "Set aliases for start interactive bash sessions on containers"
sleep $t
alias dev="docker exec -it ggrccore_dev_1 su vagrant"
alias devroot="docker exec -it ggrccore_dev_1 sudo su"
alias sel="docker exec -it ggrccore_selenium_1 sudo su - seluser"
alias selroot="docker exec -it ggrccore_selenium_1 sudo su"
cat << EOF
alias dev="docker exec -it ggrccore_dev_1 su vagrant"
alias devroot="docker exec -it ggrccore_dev_1 sudo su"
alias sel="docker exec -it ggrccore_selenium_1 sudo su - seluser"
alias selroot="docker exec -it ggrccore_selenium_1 sudo su"
EOF
echo "Run GGRC web-app"
sleep $t
docker exec -i ggrccore_dev_1 su vagrant -c "
   cd /vagrant/bin
   source /vagrant/bin/init_vagrant_env
   echo '-make bower components-'
   sleep $t
   sudo make -B bower_components
   echo '-build css-'
   sleep $t
   build_css
   echo '-build assets-'
   sleep $t
   build_assets"
echo "***To database reset use alias 'dev' and in bash session run 'db_reset'"
docker exec -i ggrccore_dev_1 su root -c "
   cd /vagrant/bin
   source /vagrant/bin/init_vagrant_env
#   pip install --upgrade pip
   pip install cached-property==1.3.0
   echo '-db reset-'
   sleep $t
   db_reset"
}

app_run_ggrc_flask () {
docker exec -i ggrccore_dev_1 su vagrant -c "
   cd /vagrant/bin
   source /vagrant/bin/init_vagrant_env
   echo '-launch ggrc-'
   sleep $t
   launch_ggrc"
}

app_run_ggrc_flask_hidden () {
screen -dmSU flask_hidden $(
docker exec -i ggrccore_dev_1 su vagrant -c "
   cd /vagrant/bin
   source /vagrant/bin/init_vagrant_env
   echo '-launch ggrc-'
   sleep $t
   launch_ggrc")
}

app_run_ggrc_gae () {
docker exec -i ggrccore_dev_1 su vagrant -c "
   cd /vagrant/bin
   source /vagrant/bin/init_vagrant_env
   echo '-launch ggrc_gae-'
   sleep $t
   deploy_appengine extras/deploy_settings_local.sh
   make appengine_packages_zip
   launch_gae_ggrc"
}