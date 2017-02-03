#!/usr/bin/env bash

cd temp
wget http://chromedriver.storage.googleapis.com/2.27/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo cp -rf chromedriver /usr/bin/chromedriver
sudo chown he:he /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
sudo chmod 755 /usr/bin/chromedriver