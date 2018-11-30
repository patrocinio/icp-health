NAME=kube-ops

helm repo add ibm-case https://raw.githubusercontent.com/ibm-cloud-architecture/charts/master/stable
helm repo update

echo Deleting kube-ops
helm delete --purge $NAME

echo Deploying kube-ops
helm install --name=$NAME --set service.type=NodePort,service.nodePort=30454 ibm-case/kube-ops-view