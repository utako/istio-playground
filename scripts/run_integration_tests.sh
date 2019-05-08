#!/usr/bin/env bash

set -ex

DOCKER_IMAGE="${DOCKER_IMAGE:---istio.test.hub=gcr.io/istio-release}"
DOCKER_IMAGE_TAG="${DOCKER_IMAGE_TAG:---istio.test.tag=master-latest-daily}"
TEST_ENV="kube"

# Allow command-line args to override the defaults.
while getopts ":i:t:r:d:c" opt; do
  case ${opt} in
    i)
      DOCKER_IMAGE="--istio.test.hub=${OPTARG}"
      ;;
    t)
      DOCKER_IMAGE_TAG="--istio.test.tag=${OPTARG}"
      ;;
    r)
      TESTS="--istio.test.select=${OPTARG}"
      ;;
    d)
      DIR="${OPTARG}"
      ;;
    c)
      CLEANUP="--istio.test.nocleanup"
      ;;
    \?)
      echo "Invalid option: -${OPTARG}" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "${KUBECONFIG}" ]]; then
  echo "Error: KUBECONFIG must be set!"
  exit 1
fi

integration_tests() {
  local test_directory

  if [[ -z "${DIR}" ]]; then
    test_directory="${GOPATH}/src/istio.io/istio/tests/integration/"
  else
    test_directory="${GOPATH}/src/istio.io/istio/tests/integration/${DIR}"
  fi

  pushd "${test_directory}"
    go test -v  ./... -p 1 --istio.test.env "${TEST_ENV}" --istio.test.kube.config="${KUBECONFIG}" \
      --istio.test.ci "${DOCKER_IMAGE}" "${DOCKER_IMAGE_TAG}" "${CLEANUP}" "${TESTS}"
  popd
}

integration_tests "$@"
