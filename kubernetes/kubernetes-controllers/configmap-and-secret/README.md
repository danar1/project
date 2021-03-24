## ConfigMaps and Secrets
To understand ConfigMaps and Secrets better, how they work and what are their different functions run the following workflow:
1. Run the `config-secrets.sh` script to create several ConfigMaps and Secrets, 2 applications and 2 services.
2. Follow the output and try to understand what happend in every step.
> NOTE: Try to understand the different ways you can save data in a ConfigMaps and a Secret. 
3. Access the two services. Try to understand what is the difference between the two service? 
> NOTE: To access your application on AWS run `kubectl get svc` to get your load balancer address and port. For a local kubernetes use `localhost` and the nodeport. 
4. Run the `config-secrets-cleanup.sh` script to delete all created resources.

### Read more about ConfigMaps and Secrets...
- [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/)
- [Configure a Pod to Use a ConfigMap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/)
- [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- [Distribute Credentials Securely Using Secrets](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/)


