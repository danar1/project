## Taints and Tolerations
`Taints` are applied to a node and allow it to repel a set of pods.
`Tolerations` are applied to pods, and allow (but do not require) the pods to schedule onto nodes with matching taints.
Run to following workflow to practice `taints` and `tolerations`

1. Taint and label one of your nodes in the cluster.
```bash
kubectl taint nodes <node_name> node=taint:NoSchedule
kubectl label nodes <node_name> taint=tainted
```
> **Remember:** You can use `kubectl get nodes` to get your cluster node names

2. Run 2 pods on the tainted node - one Pod that can't tolerate the taint [`pod-cant-tolerate.yaml`](pod-cant-tolerate.yaml) and another that can [`pod-tolerate.yaml`](pod-tolerate.yaml), and review your pods status. 
> **Remember:** You can use `nodeSelector` to schedule pods on spesific nodes

3. Change the taint on the node from `NoSchedule` to `PreferNoSchedule` and review your pods to see what happend.
```bash
kubectl taint nodes <node_name> node=taint:NoSchedule-
kubectl taint nodes <node_name> node=taint:PreferNoSchedule
```

4. Change the taint on the node from `PreferNoSchedule` to `NoExecute` and review your pods to see what happend.
```bash
kubectl taint nodes <node_name> node=taint:PreferNoSchedule-
kubectl taint nodes <node_name> node=taint:NoExecute
```

> **NOTE:** You can use [`taints-and-tolerations-run.sh`](taints-and-tolerations-run.sh) to run all the above examples automatically.

### Read more about Taints and Tolerations...
- [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)

[Next Step - Pod Spread Constraints](../spread-constraints/)