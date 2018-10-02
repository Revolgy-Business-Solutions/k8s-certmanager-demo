#!/bin/bash
kubectl apply -f k8s/rbac.yaml
helm init --upgrade --service-account tiller
kubectl rollout status -n kube-system deploy/tiller-deploy


helm upgrade --install nginx-ingress stable/nginx-ingress
helm upgrade --install cert-manager stable/cert-manager --namespace kube-system  --set ingressShim.defaultIssuerName=letsencrypt-prod --set ingressShim.defaultIssuerKind=ClusterIssuer

kubectl run nginx --image=nginx
kubectl expose deployment nginx --type=NodePort --name nginx --port 80

kubectl apply -f k8s/
