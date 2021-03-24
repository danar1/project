# create ReplicaSet
kubectl apply -f kuard-rs.yaml
sleep 10
# Get the pod created by the replicaset
echo "==> kubectl get pods -lapp=kuard"
kubectl get pods -lapp=kuard

# export pod name to ENV_VAR
RS_POD=$(kubectl get pods -lapp=kuard -o jsonpath="{.items[0].metadata.name}")

# delete pod created by ReplicaSet
echo "### delete a pod in the replicaset"
echo "==> kubectl delete pod "$RS_POD
kubectl delete pod $RS_POD

# export pod name to a new ENV_VAR
NEW_RS_POD=$(kubectl get pods -lapp=kuard -o jsonpath="{.items[0].metadata.name}")

if [ $RS_POD != $NEW_RS_POD ];then
    echo "Replicaset created a new pod"
    kubectl get pods --show-labels
fi

echo "### Remove pod app label"
echo "==> kubectl label pod $NEW_RS_POD "app-""
kubectl label pod $NEW_RS_POD "app-"
sleep 10
echo "==> kubectl get pods --show-labels"
kubectl get pods --show-labels

kubectl delete pod $NEW_RS_POD

echo "### Scale replicaset to 3 pods"
echo "==> kubectl scale replicaset/kuard-rs --replicas=3"
kubectl scale replicaset/kuard-rs --replicas=3
sleep 5
kubectl get pods --show-labels

kubectl delete rs kuard-rs
