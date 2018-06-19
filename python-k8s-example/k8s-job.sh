#!/usr/bin/env bash
# args 1=K8s job name
#      2=python program
python build_yaml.py $1 $2
kubectl create -f $1.yaml
