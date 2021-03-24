## Kubernetes Scheduling Workshop
Welcome to the Kubernetes scheduling workshop. This workshop will deep dive into adavanced kubernetes pod scheduling, and the different ways to hint the `kube-scheduler` how and where we would like our pods to be scheduled.

Finishing this workshop brings you one step closer in becoming a true kubernetes captain!

![kubernetes!](https://media.giphy.com/media/I5YVX2dl6ddC0/giphy.gif)

## Prerequisites
- kubectl installed on your workstation
- access to a kubernetes cluster either EKS or minikube/docker
>Note: You can find information about how to start an EKS cluster in your AWS accout [here](../eks-terraform/)

## Run the Workshop

We have several different ways to controller Pod scheduling in kubernetes:
1. [`nodeSelector` and `inter-pod affinity/anti-affinity`](assigning-pods-to-nodes/)
2. [`Taints` and `Tolerations`](taints-and-tolerations/) 
3. [Pod `topologySpreadConstraint`](spread-constraints/) 
