#!/usr/bin/env bash

set -x

echo "Searching for Docker image ..."
DOCKER_IMAGE_ID=$(docker images --format="{{.ID}}" pulseaudio:latest | head -n 1)
echo "Found and using ${DOCKER_IMAGE_ID}"

USER_UID=$(id -u)

docker run -t -i \
  --volume=/run/user/${USER_UID}/pulse:/run/user/3000/pulse \
  ${DOCKER_IMAGE_ID} \
  ${@}
