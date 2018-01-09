#!/usr/bin/env bash
kubectl apply -f nginxservice.yaml
kubectl get service
kubectl get pods
kubectl get deployments
kubectl apply -f traefix_service.yaml