
kubectl create deployment web-003 --image=nginx:1.17 --replicas=3
# If you're having issues with deploying pods check kube-controller in kube-system namespace. This component is responsible for scheduling all pods in cluster
# Check for logs in that pod
