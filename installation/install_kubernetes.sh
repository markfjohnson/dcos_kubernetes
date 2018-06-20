#!/usr/bin/env bash
dcos security org service-accounts keypair k8s-private-key.pem k8s-public-key.pem
dcos security org service-accounts delete kubernetes   ##in case exhists
dcos security org service-accounts create -p k8s-public-key.pem -d 'Kubernetes service account' kubernetes

dcos security secrets delete kubernetes/sa   ##in case exhists
dcos security secrets create-sa-secret k8s-private-key.pem kubernetes kubernetes/sa
sleep 10
dcos security org users grant kubernetes dcos:mesos:master:framework:role:kubernetes-role create
dcos security org users grant kubernetes dcos:mesos:master:task:user:root create
dcos security org users grant kubernetes dcos:mesos:agent:task:user:root create
dcos security org users grant kubernetes dcos:mesos:master:reservation:role:kubernetes-role create
dcos security org users grant kubernetes dcos:mesos:master:reservation:principal:kubernetes delete
dcos security org users grant kubernetes dcos:mesos:master:volume:role:kubernetes-role create

sleep 10

dcos security org users grant kubernetes dcos:mesos:master:volume:principal:kubernetes delete
dcos security org users grant kubernetes dcos:service:marathon:marathon:services:/ create
dcos security org users grant kubernetes dcos:service:marathon:marathon:services:/ delete
dcos security org users grant kubernetes dcos:secrets:default:/kubernetes/\* full
dcos security org users grant kubernetes dcos:secrets:list:default:/kubernetes read
dcos security org users grant kubernetes dcos:adminrouter:ops:ca:rw full

sleep 10

dcos security org users grant kubernetes dcos:adminrouter:ops:ca:ro full
dcos security org users grant kubernetes dcos:mesos:master:framework:role:slave_public/kubernetes-role create
dcos security org users grant kubernetes dcos:mesos:master:framework:role:slave_public/kubernetes-role read
dcos security org users grant kubernetes dcos:mesos:master:reservation:role:slave_public/kubernetes-role create
dcos security org users grant kubernetes dcos:mesos:master:volume:role:slave_public/kubernetes-role create

##
dcos security org users grant kubernetes dcos:mesos:master:framework:role:slave_public read
dcos security org users grant kubernetes dcos:mesos:agent:framework:role:slave_public read

# install k8s - please add your options - this is default single node using service account & secret created in previous step
dcos package install --yes kubernetes --options=k8s_options.json

# Setup marathon proxxy
dcos marathon app add kubectl-proxy.json

dcos kubernetes kubeconfig --apiserver-url https://54.202.229.0:6443 --insecure-skip-tls-verify --no-activate-context
kubectl proxy

# http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/

