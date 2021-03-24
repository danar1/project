## Labels and Services
To understand lables and services better, how they work and what are their different functions run the following workflows

### Lables

1. Run the `labels-setup.sh` script to create the 4 applications.
2. Run the `labels-run.sh` script and follow the output. Try to understand what happend in every step.

### Services
1. Run the `service-setup.sh` script to create our 2 productions applications and services.
>**NOTE:** You have to run this step on AWS or convert the services to NodePort services
2. Run the `service-run.sh` script.
3. Get into your frontend application and select the *Readiness Probe* tab on the left. Fail the application 5 times and see what happens in your terminal.
4. Run the `service-cleanup.sh` script to delete all created resources.

### Read more about labels and services...
- [Labels and Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
- [Kubernetes services](https://kubernetes.io/docs/concepts/services-networking/service/)

[Next Step - Ingress](../ingress/)