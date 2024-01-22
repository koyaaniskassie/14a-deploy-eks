#!/bin/zsh
cd terraform
terraform workspace select brasov
terraform apply -auto-approve
aws eks --region eu-central-1 update-kubeconfig --name education-eks --profile brasov
cd ../k8s/argocd
helm repo add argo-helm https://argoproj.github.io/argo-helm
helm dependency build
helm install argocd . -f values.yaml -f values-secrets.yaml --namespace argocd --create-namespace
cd ../argocd-apps
helm dependency build
helm install argocd-apps . -f values.yaml --namespace argocd --create-namespace