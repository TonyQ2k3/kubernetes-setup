## References
[CRI-O installation](https://github.com/cri-o/packaging/blob/main/README.md)

[Kubeadm installation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

## Provision infrastructure
```bashe 
terraform init
terraform plan
terraform apply --auto-approve
```

## Prepare the nodes
1. SSH into nodes
2. Run installation scripts
```bash
chmod +x common.sh
./common.sh
```

## Initialize the cluster (multi-masters)
1. SSH into the first node
2. Execute the init script
```bash
chmod +x multi-master-init.sh
./multi-master-init.sh
```
3. Enter DNS name or IP of the Network Load Balancer created.
4. If calico network step fails, simply re-run the `kubectl apply` command after a while.


## Join the cluster
On the first node, run `kubeadm token create --print-join-command` to get the join command and run it on the other nodes.

## Reset the cluster
```bash
sudo kubeadm reset
sudo systemctl restart kubelet
sudo rm -rf ~/.kube
```