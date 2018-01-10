#!/usr/bin/env bash
kubectl delete service --all
kubectl delete deployments --all
kubectl delete ingress --all
kubectl apply -f nginxservice.yaml
kubectl apply -f traefix_service.yaml
echo "------List services"
kubectl get service
echo "------List Pods"
kubectl get pods
echo "------List Deployments"
kubectl get deployments
echo "------List Ingress"
kubectl get ingress
echo "------List Taints"
kubectl get nodes -o go-template-file="./nodes-taints.tmpl"