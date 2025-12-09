#!/usr/bin/env bash
set -e
echo "Stopping any existing containers of this image..."
docker compose down
echo "Deploying Container..."
docker compose up --build -d

