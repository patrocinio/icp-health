echo Endpoint: $endpoint
kubectl exec k8s-master-ucarp-$endpoint /etc/vip-up.sh ens160 $vip_endpoint
