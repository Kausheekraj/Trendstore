#!/usr/bin/env bash
if [[ "${1}" == rm ]];then
  echo "Removing Your Nginx Image... "
docker compose down --rmi all --volumes --remove-orphans
else
  echo "Stopping containers..."
docker compose down
exit 0
fi
