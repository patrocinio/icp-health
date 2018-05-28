echo Endpoint: $endpoint
kubectl exec k8s-master-ucarp-$endpoint /etc/vip-up.sh ens192 $vip_endpoint
