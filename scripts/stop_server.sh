#!/bin/bash
set -e

if pm2 describe my-node-app >/dev/null 2>&1; then
  pm2 stop my-node-app || true
  pm2 delete my-node-app || true
  pm2 save || true
fi
