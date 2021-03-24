# create Deploy v1
kubectl apply -f deploy-v1.yaml

# Drill down from deployment to pods
echo "### Show Deployments, ReplicaSets and Pods"
echo "==> kubectl get deploy -lapp=opsschool-app -o wide"
kubectl get deploy -lapp=opsschool-app -o wide
echo "==> kubectl get replicasets --selector=app=opsschool-app"
kubectl get replicasets --selector=app=opsschool-app
echo "==> kubectl get pods --selector=app=opsschool-app --show-labels"
kubectl get pods --selector=app=opsschool-app --show-labels

DEPLOY_RS=$(kubectl get rs  -lapp=opsschool-app -o jsonpath="{.items[0].metadata.name}")
echo "### Scale RS to from 2 to 3 replicas"
echo "==> kubectl scale rs $DEPLOY_RS --replicas=3"
kubectl scale rs $DEPLOY_RS --replicas=3 
echo "==> kubectl get replicasets --selector=app=opsschool-app"
kubectl get replicasets --selector=app=opsschool-app
 
# create Deploy v2
echo "### Update the deployment to v2"
kubectl apply -f deploy-v2.yaml

echo "==> kubectl rollout pause deployments opsschool-app"
kubectl rollout pause deployments opsschool-app

echo "==> kubectl get replicasets -o wide"
kubectl get replicasets -o wide
sleep 5

echo "==> kubectl rollout resume deployments opsschool-app"
kubectl rollout resume deployments opsschool-app

echo "==> kubectl rollout status deployments opsschool-app"
kubectl rollout status deployments opsschool-app

echo "==> kubectl get replicasets -o wide"
kubectl get replicasets -o wide

echo "### Check the version history of our deployment"
echo "==> kubectl rollout history deployment opsschool-app"
kubectl rollout history deployment opsschool-app

echo "==> kubectl rollout history deployment opsschool-app --revision=2"
kubectl rollout history deployment opsschool-app --revision=2

echo "### ReplicaSets before fallback"
echo "==> kubectl get replicasets -o wide"
kubectl get replicasets -o wide
echo "==> kubectl rollout undo deployments opsschool-app"
kubectl rollout undo deployments opsschool-app

echo "### ReplicaSets after fallback"
echo "==> kubectl get replicasets -o wide"
kubectl get replicasets -o wide
echo "==> kubectl rollout history deployment opsschool-app"
kubectl rollout history deployment opsschool-app

kubectl delete deploy opsschool-app
