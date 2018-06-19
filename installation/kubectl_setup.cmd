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


