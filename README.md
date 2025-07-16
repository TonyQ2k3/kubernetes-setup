References
====
[CRI-O installation](https://github.com/cri-o/packaging/blob/main/README.md)

[Kubeadm installation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

[Connect kubectl to EKS](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)

Provision infrastructure
====
The main.tf file includes both EKS and self-managed Kubeadm cluster with EC2, you only need to use one of them, so comment out the other.
```bash
terraform init
terraform plan
terraform apply --auto-approve
```

Self-managed Kubeadm cluster
====

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


## Join the nodes
After running the `multi-master-init.sh`, the console should print out the join command, copy and run it on the other nodes.
If you missed or lost it, on the first node, run `kubeadm token create --print-join-command` to get a new join command.

## Reset the cluster
Run this script to delete the cluster and undo the initialization process.
```bash
chmod +x reset-cluster.sh
./reset-cluster.sh
```

EKS Cluster
====
## Create the cluster
Before running `terraform apply`, make sure you modify [role_arn](infra\modules\eks\variables.tf) to match your role in IAM (it should have sufficient permissions too).

## Connecting kubectl to the cluster
```bash
aws eks update-kubeconfig --region region-code --name my-cluster
```
