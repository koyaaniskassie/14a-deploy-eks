# TERRAFORM
---
```
aws sso login --profile brasov
cd terraform
terraform init -upgrade
terraform workspace new brasov
terraform workspace select brasov
terraform apply
```

# KUBERNETES
---
## Update kube config
`aws eks --region eu-central-1 update-kubeconfig --name education-eks --profile brasov`

## Deploy ArgoCD

### Prepare file values-secrets.yaml
To make deployment faster and automated AND secure the `values-secrets.yaml` is created to hold sensitive values like private key to connect to the repository. Copy code below and paste it in `k8s/argocd/values-secrets.yaml`
```
argo-cd:
  credentialTemplates:
    14a-deploy-eks:
      url: git@github.com:rafnow1403/14a-deploy-eks.git
      sshPrivateKey: |
        -----BEGIN OPENSSH PRIVATE KEY-----
        <PASTE YOUR PRIVATE KEY HERE>
        -----END OPENSSH PRIVATE KEY-----

  repositories:
    14a-deploy-eks:
      url: git@github.com:rafnow1403/14a-deploy-eks.git
      name: 14a-deploy-eks 
```


While installing Argo (not sure why yet) first ArgoCD must be initialised THEN you can deploy argocd-apps. Base argo definition probably adds CRDs that argocd-apps will use to deploy.
```
cd k8s/argocd
kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable # install CRDs
helm repo add argo-helm https://argoproj.github.io/argo-helm # add argocd repository
helm dependency build # only first time when Chart.lock in k8s/argocd doesn't exist. This will create directory charts and download charts stated in Chart.yaml
helm install argocd . -f values.yaml --namespace argocd --create-namespace
```