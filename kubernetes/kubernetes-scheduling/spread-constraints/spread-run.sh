

echo "### Create an applicated deployment spread across AZs and nodes"
kubectl apply -f spread.yaml
sleep 5

echo "### Displey the nodes and pods shchedule"
echo "==> kubectl get nodes "
kubectl get nodes -o custom-columns=NAME:'{.metadata.name}',REGION:'{.metadata.labels.topology\.kubernetes\.io/region}',ZONE:'{metadata.labels.topology\.kubernetes\.io/zone}' 
kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName
echo "==> kubectl get pods"
kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName

DEPLOY_NAME=$(kubectl get deploy -lapp=kuard-spread -o jsonpath="{.items[0].metadata.name}")
kubectl scale deploy $DEPLOY_NAME --replicas 6
sleep 5
echo "==> kubectl get pods"
kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName

kubectl scale deploy $DEPLOY_NAME --replicas 7
sleep 5
echo "==> kubectl get pods"
kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName

echo "### Cleanup"
kubectl delete -f spread.yaml
sleep 5

echo "### Create an application spread accoss AZs and nodes exloding a spcific AZ"
kubectl apply -f spread-node-affinity.yaml
sleep 5

echo "### Displey the nodes and pods shchedule"
echo "==> kubectl get nodes "
kubectl get nodes -o custom-columns=NAME:'{.metadata.name}',REGION:'{.metadata.labels.topology\.kubernetes\.io/region}',ZONE:'{metadata.labels.topology\.kubernetes\.io/zone}' 

echo "==> kubectl get pods"
kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName

echo "### Cleanup"
kubectl delete -f spread-node-affinity.yaml