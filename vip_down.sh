echo Endpoint: $endpoint
kubectl exec k8s-master-ucarp-$endpoint /etc/vip-down.sh ens192 $vip-endpoint
