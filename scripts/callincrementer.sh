#!/bin/bash

while true; do
  curl -s http://${1}/${2}
  sleep 1.2
done
