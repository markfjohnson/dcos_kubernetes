#!/usr/bin/env bash

#
# https://www.haproxy.com/blog/haproxy_ingress_controller_for_kubernetes/
#
kubectl apply -f ingress-default-deployment.yaml
kubectl apply -f http-svc-deployment.yaml

kubectl apply -f http-svc-ingress.yaml
kubectl apply -f haproxy-configmap.yaml
kubectl apply -f haproxy-ingress-deployment.yaml
kubectl apply -f haproxy-ingress-svc.yaml

curl -s -XGET -H 'Host: foo.bar' 'http://10.0.5.162:80/app'