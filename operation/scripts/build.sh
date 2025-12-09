#!/usr/bin/env bash
set -e 
echo  "Buildling custom Nginx image"
docker compose build --no-cache

