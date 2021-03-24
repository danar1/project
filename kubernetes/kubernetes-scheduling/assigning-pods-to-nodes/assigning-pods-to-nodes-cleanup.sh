echo "### affinity-and-antiaffinity-cleanup"
# cleanup
kubectl delete -f nodeselector-instance-type.yaml
kubectl delete -f nodeselector-in-nodeaffinity.yaml
kubectl delete -f pod-affinity.yaml
kubectl delete -f pod-antiaffinity.yaml
kubectl delete -f deployment-ha-host.yaml
kubectl delete -f deployment-ha-host-zone.yaml