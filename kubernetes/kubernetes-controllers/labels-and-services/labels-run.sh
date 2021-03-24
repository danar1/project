# Run some commands with labels
echo "==> kubectl get deployments --show-labels"
kubectl get deployments --show-labels

echo "### add canary tag to backend-test deployment"
echo "==> kubectl label deployments backend-test "canary=true""
kubectl label deployments backend-test "canary=true"

echo "==> kubectl get deployments -L canary"
kubectl get deployments -L canary

echo "==> kubectl label deployments backend-test "canary-""
kubectl label deployments backend-test "canary-"

# Use label selectors
echo "==> kubectl get pods --show-labels"
kubectl get pods --show-labels

echo "==> kubectl get pods --selector="ver=2""
kubectl get pods --selector="ver=2"

echo "==> kubectl get pods --selector="app=backend,ver=2""
kubectl get pods --selector="app=backend,ver=2"

echo '==> kubectl get pods --selector="app in (backend,cyberschool)"'
kubectl get pods --selector="app in (backend,cyberschool)"

echo "==> kubectl get deployments --selector="canary""
kubectl get deployments --selector="canary"

echo "### clean all applications"
kubectl delete deployments --all