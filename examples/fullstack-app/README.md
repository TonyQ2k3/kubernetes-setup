# About
This directory contains infrastructure needed to deploy a full-stack web application, using Kubernetes and AWS's RDS. 

It's intended for dev/test only, not for production.

# Installation
You can deploy any app you like, but you can use my app if you don't have your own.

First, provision the cluster and RDS database using the guide in the repo's README.

When the cluster is up and ready, from your local machine:
```bash
helm upgrade ingress-nginx -n ingress ingress-nginx/ingress-nginx  --set controller.service.type=NodePort --set controller.service.nodePorts.http=30080

helm install libba oci://registry-1.docker.io/tonyq2k3/library-manager --version 2.0.0 -n test --create-namespace --set database.service.url=<rds_endpoint_url_only>
```