## Pod Topology Spread Constraints
You can use topology spread constraints to control how Pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains. This can help to achieve high availability as well as efficient resource utilization.
Run to following workflow to practice `topologySpreadConstraints`

1. Use [spread.yaml](spread.yaml) to create a new application spread across AZs and hosts. 
Focus on this part of the Pod.spec and understand how the `topologySpreadConstraints` is defined.
```yaml
      topologySpreadConstraints:
      - maxSkew: 1
        topologyKey: zone
        whenUnsatisfiable: DoNotSchedule
        labelSelector:
          matchLabels:
            app: kuard-spread
      - maxSkew: 1
        topologyKey: node
        whenUnsatisfiable: DoNotSchedule
        labelSelector:
          matchLabels:
            app: kuard-spread
```
2. Check your Pods and verify they are spread across hosts and zones. Try to remeber how you can use `kubectl get pods` to get your nodes info.

3. Scale your application deployment to 6 and 7 replicas. Each time you scale your application verify the Pods spread across hosts and zones.

4. Use [spread-node-affinity.yaml](spread-node-affinity.yaml) to create a new application spread across AZs and hosts, but excluding hosts in a specific AZ. 

5. Check your Pods and verify they are spread across all expected hosts and zones. 

> **NOTE:** You can use [`spread-run.sh`](spread-run.sh) to run all the above examples automatically.

### Read more about Pod Topology Spread Constraints...
- [Pod Topology Spread Constraints](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/)