#!/usr/bin/env bash

#set -v &&\
t=3
dir_pr="ggrc-core"
dir_run="run"

echo "***Install requirements (test envairoment)***"
echo "Install (set) components for host's OS"
sleep $t
echo "Install system packages"
sleep $t
yum install python -y ; yum install -y -- '*python*' ;\
yum install python-pip -y ; pip install --upgrade pip ;\
yum install gcc gcc-c++ autoconf automake ccache -y ; yum groupinstall -y 'Development Tools' ;\
echo "Install docker" &&\
sleep $t
sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/fedora/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
yum install docker-engine -y; systemctl enable docker.service ; systemctl start docker ;\
echo "Install chrome and chromedriver" &&\
sleep $t
sudo tee /etc/yum.repos.d/google-chrome.repo <<-'EOF'
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
yum install google-chrome-stable -y &&\
yum install chromedriver -y &&\
echo "Install virtual framebuffer X server" &&\
yum install xorg-x11-server-Xvfb -y ; yum install xorg-x11-server-Xephyr -y &&\


echo "Install components for local python"
sleep $t
pip install -U -r ./../$dir_pr/src/requirements-dev.txt &&\


echo "Install components for virtualenv python"
sleep $t
virtualenv -p /usr/bin/python2.7 /pysel &&\
chown -R ${USER:=$(/usr/bin/id -run)}:$USER /pysel ;\
source /pysel/bin/activate &&\
pip install -r ./../$dir_pr/src/requirements-selenium.txt &&\
deactivate
echo "Set persistence system variables"
sleep $t
PYPATH='export PYTHONPATH="${PYTHONPATH}/ggrc-core/:/ggrc-core/src:/ggrc-core/test/:/ggrc-core/test/selenium/:/ggrc-core/test/selenium/src:/ggrc-core/test/selenium/src/lib"' &&\
grep -q -F "$PYPATH" /etc/profile || echo "$PYPATH" >> /etc/profile ;\
source /etc/profile &&\
echo $PYTHONPATH $$ \


sleep $t
echo "***Your current display resolution is: "
xdpyinfo  | grep 'dimensions:' ;\
echo "The tests should run on at least 1920x1080 display resolution" &&\
sleep $t
#set +v