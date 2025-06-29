```
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
helm install jenkins jenkinsci/jenkins -f values.yaml -n jenkins
```

Prepare volume path:
```bash
mkdir -p /var/jenkins_home
chown -R $runAsUser:$fsGroup /var/jenkins_home
chmod -R g+rwX /var/jenkins_home
```

```bash
kubectl create namespace jenkins
kubectl apply -f service-account.yaml
kubectl apply -f volumes.yaml
kubectl apply -f deployment.yaml
```

Install AWS EBS CSI Driver
