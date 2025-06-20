#!/bin/bash

# Updating software dep
sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo apt autoclean

# Installing code deploy agent
sudo apt install ruby-full
sudo apt install wget
wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
systemctl status codedeploy-agent
systemctl start codedeploy-agent
systemctl status codedeploy-agent

# Install node js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
node -v

# Install process manager
npm install -g pm2

# Symlink apps
sudo ln -s "$(which node)" /sbin/node
sudo ln -s "$(which npm)" /sbin/npm
sudo ln -s "$(which pm2)" /sbin/pm2

# Installing application
sudo chown -R ubuntu:ubuntu /mnt
cd /mnt
git clone https://github.com/shahnotes/aws-nodejs-ci-cd
cd aws-nodejs-ci-cd
cp .env.prod .env
npm install --production

# Starting backend process to run nodejs application
sudo pm2 start app.js --name=nodejs-express-app
sudo pm2 save
sudo pm2 startup
