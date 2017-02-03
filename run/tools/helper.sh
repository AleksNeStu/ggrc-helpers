#!/usr/bin/env bash

helper_check_pytest_ini () {
if grep -qF "http://dev:8080" ./../ggrc-core/test/selenium/pytest.ini
then return 0 # true
else return 1 # false
fi
}

helper_check_resolution () {
echo "Your current display resolution : " ; xdpyinfo  | grep "dimensions:" ;\
echo "The tests should run on at least 1920x1080 display resolution"
}

helper_copy_pytest_ini () {
if helper_check_pytest_ini
then cp -rf add/pytest.ini ./../ggrc-core/test/selenium/
else :
fi
}

helper_copy_pytest_ini_origin () {
if helper_check_pytest_ini
then :
else cp -rf temp/pytest.ini ./../ggrc-core/test/selenium/
fi
}

helper_docker_stop_all_containers () {
docker stop $(docker ps)
}

helper_docker_stop_ggrccore_dev () {
if docker ps | grep -q "ggrccore_dev_1"
then
docker stop ggrccore_dev_1
fi
}

helper_docker_stop_ggrccore_selenium () {
if docker ps | grep -q "ggrccore_selenium_1"
then
docker stop ggrccore_selenium_1
fi
}

helper_docker_stop_selenium_dev () {
if docker ps | grep -q "selenium_dev_1"
then
docker stop selenium_dev_1
fi
}

helper_docker_stop_selenium_selenium () {
if docker ps | grep -q "selenium_selenium_1"
then
docker stop selenium_selenium_1
fi
}

#docker build --rm .