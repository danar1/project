## Ingress
To understand Ingress and ingress controllers better, how they work and what are their different functions, run the following workflow.

1. Run `ingress-setup.sh` script to install an nginx ingress controller, 2 web application serices and an ingress.
2. Run the following to verify ingress access to the 2 application services:
``` bash
INGRESS_LB_CNAME=$(kubectl get ingress opsschool-ingress -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
curl -H "Host: opsschool.example.com" http://$INGRESS_LB_CNAME/hostname
curl -H "Host: opsschool.example.com" http://$INGRESS_LB_CNAME/apache
```
> **NOTE:** If you want you can also update your `/etc/hosts` file and point `opsschool.example.com` to the loadbalancer IP address. Then you will be able to curl to the address directly without the host parameter
3. Run `ingress-cleanup.sh` to clean the environment

### Read more about Ingress...
- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
- [Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
- [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/#aws)

[Next Step - ReplicaSet](../replicaset/)