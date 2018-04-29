shopt -s expand_aliases
. ./etcd.sh

etcdctl2 cluster-health
