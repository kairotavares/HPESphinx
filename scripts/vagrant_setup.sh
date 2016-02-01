#!/bin/bash

# Updates
apt-get -y update
apt-get -y upgrade

# CTF-Platform Dependencies
apt-get -y --force-yes --fix-missing install python3-pip
apt-get -y --force-yes --fix-missing install nginx
apt-get -y --force-yes --fix-missing install mongodb
apt-get -y --force-yes --fix-missing install gunicorn
apt-get -y --force-yes --fix-missing install git
apt-get -y --force-yes --fix-missing install libzmq-dev
apt-get -y --force-yes --fix-missing install nodejs-legacy
apt-get -y --force-yes --fix-missing install npm
apt-get -y --force-yes --fix-missing install libclosure-compiler-java
apt-get -y --force-yes --fix-missing install ruby-dev
apt-get -y --force-yes --fix-missing install dos2unix
apt-get -y --force-yes --fix-missing install tmux
apt-get -y --force-yes --fix-missing install openjdk-7-jdk

npm install -g coffee-script
npm install -g react-tools
npm install -g jsxhint

pip3 install -r /home/vagrant/api/requirements.txt

# Jekyll
gem install jekyll -v 2.5.3

# Configure Environment
echo 'PATH=$PATH:/home/vagrant/scripts' >> /etc/profile

# Configure Nginx
cp /vagrant/config/ctf.nginx /etc/nginx/sites-enabled/ctf
rm /etc/nginx/sites-enabled/default
mkdir -p /srv/http/ctf
service nginx restart
