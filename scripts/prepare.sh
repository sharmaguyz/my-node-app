#!/bin/bash
set -e
APP_DIR="/home/ubuntu/my-node-app"
sudo apt-get update -y && sudo apt-get install -y dos2unix
find "$APP_DIR/scripts" -type f -name "*.sh" -exec dos2unix {} \;
chmod +x "$APP_DIR"/scripts/*.sh
