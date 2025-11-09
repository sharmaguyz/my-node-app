#!/bin/bash
set -e

APP_DIR="/home/ubuntu/my-node-app"

# Ensure apt cache is fresh
sudo apt-get update -y

# Ensure curl is available (needed for NodeSource setup)
if ! command -v curl >/dev/null 2>&1; then
  sudo apt-get install -y curl
fi

# Install Node.js 18.x if missing
if ! command -v node >/dev/null 2>&1; then
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

# Install PM2 globally (idempotent)
if ! command -v pm2 >/dev/null 2>&1; then
  sudo npm i -g pm2@latest
else
  sudo npm i -g pm2@latest
fi

# App deps
cd "$APP_DIR"
if [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi

# Start PM2 on reboot for 'ubuntu' user (idempotent)
pm2 startup systemd -u ubuntu --hp /home/ubuntu >/dev/null 2>&1 || true
