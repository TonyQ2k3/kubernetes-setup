Setting up
====

### Why does K8s require Swap disabled?
"Swapping" will copy unused memory pages from RAM to disk's swapping space to free up RAM. However, K8s requires swap disabled to ensure predictable and reliable resource scheduling.

+ K8s relies on cgroup and resource request/limit to schedule pods, if a node says it has 4Gb RAM, it should be able to handle apps that need up to 4Gb RAM. If nodes secretly swap out memory to disk, that number is no longer reliable.

+ If a pod is consuming too much memory, it's better to kill it than to degrade its performance using swap, which is harder to manage.

Networking
====
 
### What does CNI do?
CNI is how pods get their IP addresses and are able to talk to each others and the outside world.
+ Assign IP addresses to pod, configure networking routes to enable communication.
+ All containers within the same pod share the same network namespace (and IP address).
+ All nodes and pods can communicate without NAT.
+ Manage network policies.

When a pod is created, K8s asks CNI to:
+ Create a virtual networking interface for the pod.
+ Assign IP address to the pod (from pod CIDR).
+ Setup routes and connect it to the cluster's overlay/bridge network.

What CNI DOES NOT do:
+ DNS: It's handle by CoreDNS
+ LoadBalancing/Ingress
+ Service discovery

### Network Policy
By default, all pods can communicate to each other (no restrictions). Network policies help allowing/denying access from pods to pods (like a firewall or a security group)

RBAC
====

### What is ServiceAccount primarily used for?
ServiceAccount is used to provide an identity for processes running inside pods when working with the K8s API. A ServiceAccount can allow or prevent a pod from reading ConfigMap, Secret, or creating resources.

In cloud environments, SA can also be mapped to IAM entities, allowing pods to access cloud resources like S3, EC2, RDS etc.

Taint and Toleration
====
### What is T&T
Taint a node to repel all pods, then add a 