#!/usr/bin/env bash

set -ex

istio_docker() {
  local istio_dir
  istio_dir="${1}"

  if [[ -z "${istio_dir}" ]]; then
    echo "WARNING: istio_dir not set"
    echo "Setting istio directory to ~/workspace/istio-playground/src/"
    echo "You may optionally pass your preferred istio directory as the first argument 😀 "
    istio_dir="${HOME}/workspace/istio-playground/src/"
  else
    echo "istio_directory set to ${istio_dir}"
  fi

  echo "Getting istio/ci tags..."
  local tag
  tag=$(curl -s "https://hub.docker.com/v2/repositories/istio/ci/tags/" | jq -r '.results|.[0].name')

  echo "Getting most recent istio/ci images..."
  docker pull istio/ci:"${tag}"

  local image_id
  image_id=$(docker images -f reference=istio/ci --format "{{.ID}}" | head -n1)

  docker run -u root -it --cap-add=NET_ADMIN -v "${istio_dir}":/go/src/ -v "${HOME}/workspace/istio-playground/scripts/":/scripts/ "${image_id}" /bin/bash
}

istio_docker "$@"
