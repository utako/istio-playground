#!/usr/bin/env bash

set -ex

pushd "${GOPATH}/src/istio.io/istio/"
  echo "Running linters on your changes..."
  bin/linters.sh -s HEAD^
popd
