#!/bin/bash
#
# Setup for master nodes

set -euxo pipefail

POD_CIDR="192.168.0.0/16"

echo "Please enter LoadBalancer IP or DNS: "
read -r MASTER_PUBLIC_IP

# Pull required images
sudo kubeadm config images pull

# Initialize the cluster
sudo kubeadm init --control-plane-endpoint="$MASTER_PUBLIC_IP" --apiserver-cert-extra-sans="$MASTER_PUBLIC_IP" --pod-network-cidr="$POD_CIDR" --upload-certs --ignore-preflight-errors Swap

# Configure kubeconfig
mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config


# Install Claico Network Plugin Network 
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml