# $1 host-pattern
# $2 command

CLUSTER_DIR=/opt/icp-install/cluster

ansible $1 -i $CLUSTER_DIR/hosts -e @$CLUSTER_DIR/config.yaml --private-key=$CLUSTER_DIR/ssh_key -a "$2"
