# get all nodes
echo "### Show node information/labels"
kubectl get nodes --show-labels
kubectl get nodes -o custom-columns=NAME:'{.metadata.name}',INSTANCE_TYPE:'{.metadata.labels.node\.kubernetes\.io/instance-type}',ZONE:'{metadata.labels.topology\.kubernetes\.io/zone}' 

# deploy pod with nodeSelector
echo "### create a deployment with pods node selector instance type"
kubectl apply -f nodeselector-instance-type.yaml
sleep 5
echo "### create a a pod with node affinity: node.kubernetes.io/instance-type"
# deploy pod with nodeAffinity
kubectl apply -f nodeselector-in-nodeaffinity.yaml
sleep 5
echo "### Show the pods node information"
echo "==> kubectl get pods -o wide -Lapp=nodeselector-linux"
kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName -Lapp=nodeselector-linux

echo "### Show node information/labels"
kubectl get nodes -o custom-columns=NAME:'{.metadata.name}',INSTANCE_TYPE:'{.metadata.labels.node\.kubernetes\.io/instance-type}',ZONE:'{metadata.labels.topology\.kubernetes\.io/zone}' 


# deploy 2 pods in the same host
echo "## Use pod affinity to deploy 2 pods on the same host"
kubectl apply -f pod-affinity.yaml
sleep 5

echo "==> kubectl get pods -lservice=core"
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName -lservice=core

# deploy 1 pod not with service=core
echo "### Use pod anti-affinity to deploy another pod on a different host"
kubectl apply -f pod-antiaffinity.yaml
echo "==> kubectl get pods -lservice=not-core"
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName -lservice=not-core

# deploy 1 pod per host
echo "### Deploy an application (deployment) were each pod is in a seperate host"
kubectl apply -f deployment-ha-host.yaml
sleep 5

echo "==> kubectl get pods -lapp=antiaffinity-host"
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName -lapp=antiaffinity-host

# deploy 1 pod per host spread AZ
echo "### Deploy an application (deployment) were each pod is in a seperate AZ"
kubectl apply -f deployment-ha-host-zone.yaml
sleep 5

echo "==> kubectl get pods -lapp=pod-ha-host-zone -o wide"
kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName -lapp=pod-ha-host-zone
