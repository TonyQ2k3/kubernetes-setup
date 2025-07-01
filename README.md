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
4. If calico network step fails, simply re-run the `kubectl apply` command after a moment.


## Join the cluster
After running the `multi-master-init.sh`, the console should print out the join command, copy and run it on the other nodes.
If you missed or lost it, on the first node, run `kubeadm token create --print-join-command` to get a new join command.

## Reset the cluster
```bash
chmod +x reset-cluster.sh
./reset-cluster.sh
```