#!/bin/bash
set -e

# Stop and remove the app from PM2 if it exists
if pm2 describe my-node-app >/dev/null 2>&1; then
  pm2 stop my-node-app || true
  pm2 delete my-node-app || true
  pm2 save || true
fi
