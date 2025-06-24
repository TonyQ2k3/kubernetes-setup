## Provision infrastructure
```bash
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

## Remove CRI disable option
1. Edit `/etc/containerd/config.toml` and comment out `disabled_plugins = ["cri"]`
2. Restart containerD with `sudo systemctl restart containerd`


## Initialize the cluster
```

```