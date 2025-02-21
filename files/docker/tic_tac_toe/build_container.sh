#!/usr/bin/env bash

image_name="tic-tac-toe-image"
container_name="tic-tac-toe-container"

if [ "$EUID" -ne 0 ]; then
  echo "Script must be run as root"
else
  docker build -t $image_name .
  
  if [ $? -eq 0 ]; then
    docker run --name $container_name -d -p 80:80 $image_name
    if [ $? -eq 0 ]; then
      echo "Container $container_name built and is running successfully"
      docker ps -a
      echo "Visit http://localhost to view your page"
    else
      echo "Running the container failed."
     fi
  else
    echo "Building image $image_name failed"
  fi
fi
