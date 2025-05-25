#!/usr/bin/env sh

set -e
set -o pipefail

ARGO_WORKFLOWS_VERSION="v3.6.7"
ARGO_CD_VERSION="v3.0.3"
ARGO_ROLLOUTS_VERSION="v1.8.2"
ARGO_EVENTS_VERSION="v1.9.6"

# Argo Workflows
kubectl create namespace argo || true
kubectl apply -n argo -f \
    https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/quick-start-minimal.yaml

# Argo Events
kubectl create namespace argo-events || true
kubectl apply -f \
    https://raw.githubusercontent.com/argoproj/argo-events/${ARGO_EVENTS_VERSION}/manifests/install.yaml
#kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/${ARGO_EVENTS_VERSION}/examples/eventbus/native.yaml
#kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/${ARGO_EVENTS_VERSION}/examples/event-sources/webhook.yaml

# Argo CD
kubectl create namespace argocd || true
kubectl apply -n argocd -f \
    https://raw.githubusercontent.com/argoproj/argo-cd/${ARGO_CD_VERSION}/manifests/install.yaml

# Argo Rollouts
kubectl create namespace argo-rollouts || true
kubectl apply -n argo-rollouts -f \
    https://github.com/argoproj/argo-rollouts/releases/download/${ARGO_ROLLOUTS_VERSION}/install.yaml
