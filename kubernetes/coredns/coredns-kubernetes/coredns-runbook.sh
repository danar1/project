
# ClusterIP Service
echo "### Create clusterIP service"
kubectl create -f deployment.yaml
kubectl create -f service.yaml
kubectl apply -f dnstools.yaml
sleep 5

echo "===> dig -t a service-cluster.default.svc.cluster.local"
kubectl exec -i -t dnsutils -- dig -t a service-cluster.default.svc.cluster.local

# Headless Service - without hostname/stbdomain
echo "### Create Headless Service"
kubectl delete svc service-cluster
kubectl create -f service-headless.yaml
echo "===> dig -t a service-headless.default.svc.cluster.local"
kubectl exec -i -t dnsutils -- dig -t a service-headless.default.svc.cluster.local
echo "===> dig -t srv service-headless.default.svc.cluster.local"
kubectl exec -i -t dnsutils -- dig -t srv service-headless.default.svc.cluster.local
kubectl exec -i -t dnsutils -- ping -c 3 service-headless

echo "===> host -v example.com"
kubectl exec -i -t dnsutils -- host -v example.com
echo "===> kubectl get svc -n kube-system"
kubectl get svc -n kube-system
echo "===> cat /etc/resolv.conf"
kubectl exec -i -t dnsutils -- cat /etc/resolv.conf

# Headless Service - with hostname/stbdomain
echo "### Create Headless Service with hostname"
kubectl delete deploy headless
kubectl create -f deployment-host.yaml
echo "===> dig -t srv service-headless.default.svc.cluster.local"
kubectl exec -i -t dnsutils -- dig -t srv service-headless.default.svc.cluster.local

# Headless Service - with hostname/stbdomain
echo "### Create Headless Service with statefulset"
kubectl delete deploy headless
kubectl create -f statefulset.yaml
echo "===> dig -t srv service-headless.default.svc.cluster.local"
kubectl exec -i -t dnsutils -- dig -t srv service-headless.default.svc.cluster.local

# wild card queries
echo "===> host *.default.svc.cluster.local."
kubectl exec -i -t dnsutils -- host *.default.svc.cluster.local.
echo "===> host kube-dns.kube-system.svc.cluster.local."
kubectl exec -i -t dnsutils -- host kube-dns.kube-system.svc.cluster.local.
echo "===> host *.kube-dns.kube-system.svc.cluster.local."
kubectl exec -i -t dnsutils -- host *.kube-dns.kube-system.svc.cluster.local.

echo "### cleanup"
kubectl delete -f statefulset.yaml
kubectl delete -f service-headless.yaml
kubectl delete -f dnstools.yaml

