#!/usr/bin/env bash
dcos package install kubernetes --package-version=1.0.3-1.9.7
dcos package install --yes kubernetes
dcos package install --yes --cli dcos-enterprise-cli
dcos package install --yes mysql
dcos package install --yes hdfs --options=hdfs_option-no-svc.json
dcos package install --yes marathon-lb
dcos package install --yes cassandra
#TODO Setup spark history configuration
dcos package install --yes spark
dcos package install --yes kafka
dcos package install --yes jenkins

sleep 60
dcos kubernetes kubeconfig
kubectl delete deployments --all
kubectl delete service --all
kubectl delete ds --all
kubectl delete serviceaccounts --all
kubectl delete ingress --all
kubectl delete namespace --all
kubectl delete pods --all

kubectl create -f k8s-admin-user.yaml

kubectl create -f config-map.yaml
kubectl create -f traefik.yaml

kubectl create -f ../wls12_benefits_k8s/benefits_traefik.yaml


