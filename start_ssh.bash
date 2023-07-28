#!/bin/bash

sleep 50

start_tunnel() {
  ssh -o ExitOnForwardFailure=yes -N -R 7624:localhost:22 rkssh@rkssh.rev.vet
}

check_tunnel() {
  ssh -q -o "BatchMode=yes" -O check -p 7624 rkssh@rkssh.rev.vet
}

check_internet() {
  while true; do
    if ping -c 1 google.com &> /dev/null; then
      echo "Internet is available."
      break
    else
      echo "Internet connection is lost. Checking again in 5 seconds..."
      sleep 5
    fi
  done
}

while true; do
  check_internet

  if ! check_tunnel; then
    echo "SSH tunnel is not active. Restarting in 5 seconds..."
    sleep 5

    start_tunnel

    sleep 5
  else
    echo "SSH tunnel is active."
  fi
  sleep 5
done
