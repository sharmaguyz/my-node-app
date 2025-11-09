#!/bin/bash
set -e
APP_DIR="/home/ubuntu/my-node-app"

cd "$APP_DIR"

if pm2 describe my-node-app >/dev/null 2>&1; then
  pm2 reload my-node-app --update-env
else
  pm2 start ecosystem.config.js --env production
fi

pm2 save
