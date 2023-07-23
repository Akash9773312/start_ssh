#!/bin/bash

sleep 50
start_tunnel() {
  ssh -N -R 7624:localhost:22 rkssh@rkssh.rev.vet
}

check_tunnel() {
  ssh -q -o "BatchMode=yes" -O check -p 7624 rkssh@rkssh.rev.vet
}

while true; do
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
