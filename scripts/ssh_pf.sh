#!/usr/bin/env bash


if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <port> <remote_target>"
  exit 1
fi

LOCAL_PORT=$1
REMOTE_TARGET=$2

ssh -N -L $LOCAL_PORT:localhost:$LOCAL_PORT  $REMOTE_TARGET
