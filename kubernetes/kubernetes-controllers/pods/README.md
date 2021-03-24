## Pods
To understand pods better, how they work and what are their different functions run the following workflow:
1. Create the service to access your pods use `pod-svc.yaml` to create a LoadBalancer type service if your running on AWS or use `pod-svc-nodeport.yaml` to create a NodePort type service if you're running on a local disto.
> **NOTE:** To access your application on AWS run `kubectl get svc` to get your load balancer address and port. For a local kubernetes use `localhost` and the nodeport. 
2. Run `podn.yaml` one at a time (delete each pod before running the next step). Each time access the application and play around with the different options to test the pod relevant functionality.
These are the different steps:
   * **Step 1 - Simple pod**
   * **Step 2 - Pod with liveness probe:** Get into your application. Select the *Livness Probe* tab on the left. Fail the application 5 times and see what happens. (use `kubectl get pods --watch` to watch your pods status)
   * **Step 3 - Pod with readiness probe:** Get into your application. Select the *Readiness Probe* tab on the left. Fail the application 5 times and see what happens. (use `kubectl get endpoints <svc name> --watch` to watch your service endpoints status)
   * **Step 4 - Pod with resource requirements:** Get into your application. Select the *Memory* tab on the left. Allocate 500MB twice and see what happens. (use `kubectl get pods --watch` to watch your pods status)
   * **Step 5 - Pod with external volume:** Get into your application. Select the *File system browser* tab on the left. Find your allocated volume in the container file system. 
   * **Step 6 - Pod with everything:** Get into your application. Play around with whatever you like.
3. Delete all pods and the service you created

### Read more about pods...
- [Kubernetes pods](https://kubernetes.io/docs/concepts/workloads/pods/)
- [kubernetes liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
- [Assign CPU Resources to Containers and Pods](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/)
- [Assign Memory Resources to Containers and Pods](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/)
- [Configure a Pod to Use a Volume for Storage](https://kubernetes.io/docs/tasks/configure-pod-container/configure-volume-storage/)

[Next Step - Labels and Services](../labels-and-services/)
