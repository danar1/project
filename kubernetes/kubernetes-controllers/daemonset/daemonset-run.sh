# create fluentd daemonset
echo "### Install a fluentd daemonset"
kubectl apply -f daemonset.yaml
sleep 20

echo "### Display to fluentd pods and the cluster nodes"
echo "===> kubectl get pods -l name=fluentd-elasticsearch -n kube-system -o wide"
# Get the pod created by the DaemonSet - pay attention to the Node names column
kubectl get pods -l name=fluentd-elasticsearch -n kube-system -o wide
echo "===> kubectl get nodes"
kubectl get nodes

echo "Cleanup"
# delete fluentd daemonset
kubectl delete -f daemonset.yaml
