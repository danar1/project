# Create Services
kubectl create -f svc.yaml
kubectl create -f tls-svc.yaml

# create configmap
kubectl create configmap my-config \
--from-file=my-config.txt \
--from-literal=extra-param=extra-value \
--from-literal=another-param=another-value

# Get ConfigMap
kubectl get configmaps my-config -o yaml

kubectl apply -f configmap.yaml

#  NOW - Go to KUARD UI and look at the Server Env tab

# get secrets
curl -O https://storage.googleapis.com/kuar-demo/kuard.crt
curl -O https://storage.googleapis.com/kuar-demo/kuard.key

kubectl create secret generic kuard-tls \
--from-file=kuard.crt \
--from-file=kuard.key

kubectl describe secrets kuard-tls

kubectl apply -f secret.yaml

#  NOW - Go to KUARD UI and look at the FileSystem tab and loof for files under /tls