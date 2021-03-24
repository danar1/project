# Coredns kubernetes workshop
Welcome to the coredns kubernetes workshop. Run the following workshop to better understand how coredns works within kubernetes.

## Prerequisites
---
- kubectl installed on your workstation
- access to a kubernetes cluster either EKS or minikube/docker
>Note: You can find information about how to start an EKS cluster in your AWS accout [here](../../eks-terraform/)

## Run the Workshop
---
### Create deployment and service

1. Create an application deployment and a service using [deployment.yaml](deployment.yaml) and [service.yaml](service.yaml).
2. Create a dnstools pod to use for dns and host queries using [dnstools.yaml](dnstools.yaml)
3. Query the cluster service address:
```bash
kubectl exec -i -t dnsutils -- dig -t a service-cluster.default.svc.cluster.local
```
>**NOTE:**  

4. Delete the service you created
---
### Create deployment and headless service
