Create deployment with nginx 1.16 then perform rolling update to 1.17
kubectl create deployment nginx-deployment --image=nginx:1.16 OR kubectl apply -f deployment.yaml
kubectl get deployment -o yaml | grep image
kubectl set image deployments/nginx-deployment nginx=nginx:1.16 --record=true # record will add change-cause in rollout history
kubectl rollout status deployment nginx-deployment

# BONUS
# Rollback to previous version
kubectl rollout history deployment nginx-deployment --revision=2