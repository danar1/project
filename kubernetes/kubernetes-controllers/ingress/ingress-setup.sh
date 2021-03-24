
# Install NGINX ingress conroller 
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/aws/deploy.yaml
sleep 60
# Create 2 appications
kubectl create -f hostname-app.yaml
kubectl create -f apache-app.yaml

kubectl create -f opsschool-ingress.yaml
sleep 120

INGRESS_LB_CNAME=$(kubectl get ingress opsschool-ingress -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
curl -H "Host: opsschool.example.com" http://$INGRESS_LB_CNAME/hostname
curl -H "Host: opsschool.example.com" http://$INGRESS_LB_CNAME/apache