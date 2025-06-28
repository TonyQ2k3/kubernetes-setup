#!/bin/bash
#
# This script resets the Kubernetes cluster by removing all components and configurations.

set -euxo pipefail

sudo kubeadm reset
sudo systemctl restart kubelet
sudo rm -rf ~/.kube