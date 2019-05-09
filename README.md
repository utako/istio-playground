# istio-playground

### Running Integration Tests
There are a few ways to do this. For K8s environment integration tests, you can
do the following:
1. [Create a GKE
   cluster](https://github.com/istio/istio/blob/master/tests/integration/create_cluster_gke.sh)
1. [Run integration tests](scripts/run_integration_tests.sh)


### Running e2e Tests
Again, there are a few ways to do this. If you'd like to use minikube, you can
do the following on a mac. There are other scripts for other operating systems:
1. [Read the
   docs](https://github.com/istio/istio/blob/master/tests/e2e/local/minikube/README.md)
1. [Install
   prereqs](https://github.com/istio/istio/blob/master/tests/e2e/local/minikube/install_prereqs_macos.sh)
1. [Set up your minikube environment](https://github.com/istio/istio/blob/master/tests/e2e/local/minikube/setup_host.sh)
1. [Build istio images on your host machine](https://github.com/istio/istio/blob/master/tests/e2e/local/minikube/setup_test.sh)
1. [Run the
   tests](https://github.com/istio/istio/blob/master/tests/e2e/local/Tips.md)

### Helpful Links

* [Running tests](https://github.com/istio/istio/wiki/Using-the-Code-Base#running-tests)
* [Istio Test Health](https://testgrid.k8s.io/istio-postsubmits)
* [Debugging with Delve](https://github.com/go-delve/delve/tree/master/Documentation/installation)
* [Delve Tutorial](http://blog.ralch.com/tutorial/golang-debug-with-delve/)
