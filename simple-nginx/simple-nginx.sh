#!/usr/bin/env bash
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-deployment.yaml
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-ds.yaml
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/ui.yaml
kubectl create -f namespace-monitor.json
kubectl create -f prometheus-ingress.yaml -n monitoring
kubectl create secret generic mysecret --from-file auth --namespace=monitoring

kubectl get pods --namespace=kube-system
kubectl get deployment --namespace=kube-system
kubectl get services --namespace=kube-system