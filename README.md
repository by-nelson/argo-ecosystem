# Argo Ecosystem
This project leverages the Argo Ecosystem to setup a DevOps platform ready for CI/CD, progressive rollouts, events and specialized workloads. It serves as a template for projects that want to modernize their ways of doing development and deployment without expending lots of money on tools.

## Requirements

- Kubernetes cluster up and running (for local development: [minikube](https://minikube.sigs.k8s.io/docs/start), [kind](https://kind.sigs.k8s.io/), etc.)

### Optional
- [Argo CLI](https://github.com/argoproj/argo-workflows/releases/)
- [Vault](https://developer.hashicorp.com/vault/install). A server in development mode is enough.

## Setup

A script is included to install all argo related tools in their common namespaces, to setup all these tools run:

```
./setup.sh
```
