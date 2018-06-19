#!/usr/bin/env bash

helm install -f values.yaml stable/prometheus
kubectl create -f prometheus.yaml