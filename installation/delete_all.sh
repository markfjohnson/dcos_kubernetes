#!/usr/bin/env bash
kubectl delete deployments --all
kubectl delete service --all
kubectl delete ds --all
kubectl delete serviceaccounts --all
kubectl delete ingress --all
kubectl delete namespace --all

kubectl delete pods --all

kubectl get all