#!/bin/bash

set -eux

clone_if_not_exist() {
  local remote=$1
  local dst_dir="$2"
  echo "Cloning $remote into $dst_dir"
  if [[ ! -d $dst_dir ]]; then
    git clone "$remote" "$dst_dir"
  fi
}

istio_path="${GOPATH}/src/istio.io/istio"

clone_if_not_exist http://github.com/istio/istio "${istio_path}"

echo "Done!"
