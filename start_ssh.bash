#!/bin/bash

start_tunnel() {
  ssh -N -R 7624:localhost:22 akash@rev.vet && echo "SSH tunnel created."
}

check_tunnel() {
  ssh -q -o "BatchMode=yes" -O check -p 7623 akash@rev.vet
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
