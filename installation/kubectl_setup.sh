#!/usr/bin/env bash
#
## property is the master ip
echo Script name: $0
echo $# arguments
if [ $# -ne 1 ];
    then echo "illegal number of parameters...pass the dcos master url"
else
    kubectl config set-cluster dcos-k8s --server=http://localhost:9000
    kubectl config set-context dcos-k8s --cluster=dcos-k8s --namespace=default
    kubectl config use-context dcos-k8s
    echo "configuring ssh tunnel for $1"
    ssh -4 -f -i ~/dcos_scripts/ccm.pem -N -L 9000:apiserver-insecure.kubernetes.l4lb.thisdcos.directory:9000 core@$1
fi