#!/usr/bin/env bash
set -x
#
## property is the master ip
HNAME=$(echo $(dcos config show core.dcos_url) | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])')
echo Script name: $0
#echo $# arguments
echo $HNAME
#if [ $# -ne 1 ];
#    then echo "illegal number of parameters...pass the dcos master url"
#el
    kubectl config set-cluster dcos-k8s --server=http://localhost:9000
    kubectl config set-context dcos-k8s --cluster=dcos-k8s --namespace=default
    kubectl config use-context dcos-k8s
    echo "configuring ssh tunnel for $HNAME"
    ssh -4 -f -i ~/dcos_scripts/ccm.pem -N -L 9000:apiserver-insecure.kubernetes.l4lb.thisdcos.directory:9000 core@$HNAME
#fi
kubectl delete deployments --all
kubectl delete service --all
kubectl delete pods --all
kubectl delete serviceaccounts --all
kubectl delete ingress --all
#cd ../k8s-prom-grafana
#kubectl create namespace prometheus
#kubectl create secret tls prometheus-server-tls --key   ../ssl/wildcard.mydomain.com.key --cert ../ssl/wildcard.mydomain.com-bundle.crt --namespace prometheus
#helm install -f values.yaml stable/prometheus --name prometheus --namespace prometheus
kubectl create -f ../wls12_benefits_k8s/nginxservice.yaml
kubectl create -f ../wls12_benefits_k8s/benefits_traefik.yaml

open http://localhost:9000/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/