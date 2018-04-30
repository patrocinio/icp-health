echo Endpoint: $endpoint
kubeclt exec k8s-master-ucarp-$endpoint /etc/vip_up.sh
