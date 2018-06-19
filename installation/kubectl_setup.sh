#!/usr/bin/env bash
set -x
#
## property is the master ip
#dcos kubernetes kubeconfig  --apiserver-url https://kube-apiserver.example.com:6443 --insecure-skip-tls-verify
#kubectl config set-cluster dcos-k8s --server=http://localhost:9000
#kubectl config set-context dcos-k8s --cluster=dcos-k8s --namespace=default
#kubectl config use-context dcos-k8s
#    echo "configuring ssh tunnel for $HNAME"
#    ssh -4 -f -i ~/dcos_scripts/ccm.pem -N -L 9000:apiserver-insecure.kubernetes.l4lb.thisdcos.directory:9000 core@$HNAME
#fi
kubectl delete deployments --all
kubectl delete service --all
kubectl delete ds --all
kubectl delete serviceaccounts --all
kubectl delete ingress --all
kubectl delete namespace --all
kubectl delete pods --all
#
kubectl create -f k8s-admin-user.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

kubectl create -f config-map.yaml
kubectl create -f traefik.yaml

kubectl create -f ../wls12_benefits_k8s/nginxservice.yaml
kubectl create -f ../wls12_benefits_k8s/benefits_traefik.yaml

### The token for the dashboard
#kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
#open http://localhost:9000/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
# http://master2a/service/kubernetes-api-proxy/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/

