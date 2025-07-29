### Schedule a pod on a specific node
1. Label the node
```bash
kubectl label node <node-name> key=value
```
2. Create pod YAML
```bash
kubectl run frontend --image=nginx --dry-run=client -o yaml > frontend.yaml
```
3. Add nodeSelector
```yaml
nodeSelector:
    key: value
```

### Expose a service
```bash
kubectl expose pod <pod-name> --name=<svc-name> --type=ClusterIP --port=80 --target-port=80
```

### Scaling deployment
```bash
kubectl scale deploy/frontend --replicas=2
```

### Auto-scaling
1. Enable metric server

2. Setup HPA
```bash
kubectl autoscale deployment/frontend --cpu-percent=80 --min=3 --max=5
```

B. Debugging
====

### Logging locations
Log locations to check:
+ `/var/log/pods` or `/var/log/containers`
+ `critctl ps` or `crictl logs`
+ `/var/log/syslog` or `journalctl` (for kubelet)

### Editting Control plane manifests
Control plane components's manifests are located in `/etc/kubernetes/manifests`.

### Finding config files
When encountering issues with the kubelet, it's worth looking for relating config files
```bash
find / | grep kubeadm
```
Some files you should focus on are `kubeadm.conf` and `kubeadm-flags.env`

### Restarting changes
```bash
sudo systemctl restart kubelet
sudo service kubelet restart
```

### RBAC
Checking permissions of service accounts
```bash
kubectl auth can-i --as=<service-account> list pods
```

### Taint and Toleration


### Image errors:
+   Docker pull failed to resolve reference -> Wrong image tag or Network connectivity.

    If it's also a timeout error -> It's network connectivity.