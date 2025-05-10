#!/bin/bash

PORT=4000
MAC_ADDR="00:11:22:33:44:55"
INTERFACE="enp3s0"

while true; do
  echo "Listening on port $PORT..."
  nc -ul $PORT | while read -r line; do
    echo "Trigger received, sending WOL..."
    etherwake -i $INTERFACE $MAC_ADDR
  done
done
