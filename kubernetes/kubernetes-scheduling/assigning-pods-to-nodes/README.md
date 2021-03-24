## Assigning Pods to Nodes
You can constrain a Pod to only be able to run on particular Node(s), or to prefer to run on particular nodes. There are several ways to do this, and the recommended approaches all use label selectors to make the selection.

### nodeSelector
nodeSelector is the simplest recommended form of node selection constraint.

Review and run [`nodeselector-instance-type.yaml`](nodeselector-instance-type.yaml) to create a deployment that runs pods only on nodes from a spesific instance type.

### Affinity and anti-affinity 
The affinity feature consists of two types of affinity, `node affinity` and `inter-pod affinity/anti-affinity`. Node affinity is similar to the existing `nodeSelector` but more flexiable, while `inter-pod affinity/anti-affinity` constrains against pod labels rather than node labels.

Review and run the following examples:
#### Node Affinity
- [`nodeselector-in-nodeaffinity.yaml`](nodeselector-in-nodeaffinity.yaml) Creates a pod with `node affinity` to a list of AWS instance types.

#### Inter-pod Affinity/Anti-Affinity
1. [`pod-affinity.yaml`](pod-affinity.yaml) Create 2 Pods with an affinity to run on the same host.
2. [`pod-antiaffinity.yaml`](pod-antiaffinity.yaml) Creates a Pods with an anti-affinity to run on a different host than the previous pods.
3. [`deployment-ha-host.yaml`](deployment-ha-host.yaml) Creates a deployment with an anti-affinity to run each pod on a different host.
4. [`deployment-ha-host-zone.yaml`](deployment-ha-host-zone.yaml) Creates a deployment with an anti-affinity to run each pod on a different AWS AZ.

> **NOTE:** You can use [`assigning-pods-to-nodes.sh`](assigning-pods-to-nodes.sh) to run all the above examples automatically, and [`assigning-pods-to-nodes.sh`](assigning-pods-to-nodes-cleanup.sh) to clean everything up.

### Read more about Affinity and Anti-Affinity...
- [Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)
- [Well-Known Labels, Annotations and Taints](https://kubernetes.io/docs/reference/kubernetes-api/labels-annotations-taints/)

[Next Step - Taints and Tolerations](../taints-and-tolerations/)