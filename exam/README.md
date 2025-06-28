# The basics

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

