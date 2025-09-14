🚀 HashiCorp Vault Demo
========================

## (Local only - Optional) Start minikube
```sh
minikube start
```

## Add the Vault Helm repo
```sh
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
```

## Create a `vault` namespace
```sh
kubectl create namespace vault
```

## Install Vault in Dev mode via Helm
```sh
helm install vault hashicorp/vault -f vault-values.yaml
```

## Access the Vault UI
```sh
kubectl port-forward svc/vault -n vault 8200:8200
```
You can get the root token via: `kubectl logs -n vault vault-0`