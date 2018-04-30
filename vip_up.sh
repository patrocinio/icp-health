echo Endpoint: $endpoint
kubectl exec k8s-master-ucarp-$endpoint /etc/vip_up.sh
