
echo "### Taint (NoSchedule) and label one node in our cluster"
NODE_NAME=$(kubectl get nodes -o jsonpath="{.items[0].metadata.name}")
kubectl taint nodes $NODE_NAME node=taint:NoSchedule
kubectl label nodes $NODE_NAME taint=tainted
kubectl get nodes -Ltaint

echo "### Run a pod that can tolerate and a pod that can't"
kubectl create -f pod-cant-tolerate.yaml
kubectl create -f pod-tolerate.yaml
sleep 5

echo "==> kubectl get pods -o wide"
kubectl get pods -o wide 

echo "### Change the taint on the node (PreferNoSchedule) "
kubectl taint nodes $NODE_NAME node=taint:NoSchedule-
kubectl taint nodes $NODE_NAME node=taint:PreferNoSchedule
sleep 5

echo "==> kubectl get pods -o wide"
kubectl get pods -o wide 

echo "### Change the taint on the node (NoExecute) "
kubectl taint nodes $NODE_NAME node=taint:PreferNoSchedule-
kubectl taint nodes $NODE_NAME node=taint:NoExecute
sleep 5

echo "==> kubectl get pods -o wide"
kubectl get pods -o wide 

kubectl taint nodes $NODE_NAME node=taint:NoExecute-
kubectl label nodes $NODE_NAME taint-
kubectl delete -f pod-cant-tolerate.yaml
kubectl delete -f pod-tolerate.yaml