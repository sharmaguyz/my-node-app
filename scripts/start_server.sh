#!/bin/bash
set -e

APP_DIR="/home/ubuntu/my-node-app"

cd "$APP_DIR"

# Start or gracefully reload via PM2
if pm2 describe my-node-app >/dev/null 2>&1; then
  pm2 reload my-node-app --update-env
else
  pm2 start ecosystem.config.js --env production
fi

# Persist process list for restarts
pm2 save
