#!/bin/bash
set -e

PORT="${PORT:-3000}"

# Ensure curl exists
if ! command -v curl >/dev/null 2>&1; then
  sudo apt-get update -y
  sudo apt-get install -y curl
fi

# Ensure PM2 process exists
pm2 describe my-node-app >/dev/null 2>&1

# Give the app a moment to bind
sleep 2

# Hit health endpoint
curl -fsS "http://127.0.0.1:${PORT}/health" >/dev/null
echo "Health check OK"
