#!/usr/bin/env bash

set -ex

CLUSTER_VERSION="1.12.6-gke.10"
MTLS_DEFAULT="MTLS_PERMISSIVE"
ZONE="us-central1-b"

main() {
  confirm

  local cluster_name
  cluster_name="${1}"

  create_cluster "${cluster_name}"
  get_cluster_credentials "${cluster_name}"
  confirm_installation
}

confirm_installation() {
  echo "Ensure the following services are deployed: istio-citadel, istio-egressgateway, istio-pilot, istio-ingressgateway, istio-policy, istio-sidecar-injector, and istio-telemetry."
  kubectl get service -n istio-system

  echo "Ensure the corresponding Kubernetes pods are deployed and all containers are up and running: istio-pilot-*, istio-policy-*, istio-telemetry-*, istio-egressgateway-*, istio-ingressgateway-*, istio-sidecar-injector-*, and istio-citadel-*."
  kubectl get pods -n istio-system
}

get_cluster_credentials() {
  local cluster_name
  cluster_name="${1}"

  echo "Getting cluster credentials..."
  gcloud container clusters get-credentials "${cluster_name}"
}

create_cluster() {
  local cluster_name
  cluster_name="${1}"

  echo "Creating clusters..."
  echo "Setting your mTLS mode to ${MTLS_DEFAULT}..."
  echo "Using cluster version ${CLUSTER_VERSION} in zone ${ZONE}..."
  gcloud beta container clusters create "${cluster_name}" \
    --addons=Istio --istio-config=auth="${MTLS_DEFAULT}" \
    --cluster-version="${CLUSTER_VERSION}" \
    --machine-type=n1-standard-2 \
    --num-nodes=4

  echo "Done!"
}

set_security_defaults() {
  cluster_name="${1}"
  gcloud beta container clusters update "${cluster_name}" \
    --update-addons=Istio=ENABLED --istio-config=auth=MTLS_PERMISSIVE
}

confirm() {
  read -r -p "Are you sure? Have you set up your gcloud stuff (iam, gcloud project)? [y/N] " response
  case $response in
    [yY][eE][sS]|[yY])
      return
      ;;

    *)
      echo "Bailing out, you said no."
      exit 187
      ;;
  esac
}

main "$@"
