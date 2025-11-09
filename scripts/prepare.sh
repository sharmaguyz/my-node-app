#!/bin/bash
set -e
sudo apt-get update -y
sudo apt-get install -y dos2unix
dos2unix scripts/*.sh || true
chmod +x scripts/*.sh
