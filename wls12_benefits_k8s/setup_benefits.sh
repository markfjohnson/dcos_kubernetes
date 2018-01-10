#!/usr/bin/env bash
kubectl delete service --all
kubectl delete deployments --all
kubectl delete ingress --all
kubectl apply -f benefits_traefik.yaml
echo "****** Waiting for everything to startup"
sleep 50
echo "------List Nodes"
kubectl get nodes --output=wide
echo "------List services"
kubectl get service
echo "------List Pods"
kubectl get pods --output=wide
echo "------List Deployments"
kubectl get deployments
echo "------List Ingress"
kubectl get ingress --output=wide
echo "------List Taints"
kubectl get nodes -o go-template-file="./nodes-taints.tmpl"
bash ~/dcos_scripts/find_public_node.sh