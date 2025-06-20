# AWS EC2 Setup for Node.js Application with CodeDeploy

This script automates the setup of a Node.js application on an Ubuntu EC2 instance using AWS CodeDeploy.

## 🔧 Step-by-Step Instructions

### 1. Update and Clean System Packages

```bash
sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo apt autoclean
```

### 2. Install AWS CodeDeploy Agent

```bash
sudo apt install ruby-full
sudo apt install wget
wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
systemctl status codedeploy-agent
systemctl start codedeploy-agent
systemctl status codedeploy-agent
```

### 3. Install Node.js

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
node -v
```

### 4. Install PM2 Process Manager

```bash
npm install -g pm2
```

### 5. Create Symlinks (Optional but useful for scripting)

```bash
sudo ln -s "$(which node)" /sbin/node
sudo ln -s "$(which npm)" /sbin/npm
sudo ln -s "$(which pm2)" /sbin/pm2
```

### 6. Clone and Set Up the Application

```bash
sudo chown -R ubuntu:ubuntu /mnt
cd /mnt
git clone https://github.com/shahnotes/aws-nodejs-ci-cd
cd aws-nodejs-ci-cd
cp .env.prod .env
npm install --production
```

### 7. Run Node.js Application with PM2

```bash
sudo pm2 start app.js --name=nodejs-express-app
sudo pm2 save
sudo pm2 startup
```

---

✅ **You're all set!** Your Node.js application is now running and managed by PM2, and the CodeDeploy agent is ready for deployment automation.