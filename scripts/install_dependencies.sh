#!/bin/bash
set -e

APP_DIR="/home/ubuntu/my-node-app"

# Update apt (safe to run repeatedly)
sudo apt-get update -y

# Node.js 18.x for Ubuntu
if ! command -v node >/dev/null 2>&1; then
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

# PM2 (idempotent)
sudo npm i -g pm2@latest

# App deps
cd "$APP_DIR"
if [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi

# PM2 resurrect on reboot for 'ubuntu' user
pm2 startup systemd -u ubuntu --hp /home/ubuntu >/dev/null 2>&1 || true
