# $1 host-pattern
# $2 command

: "${ICP_ENVIRONMENT:=/opt/ibm/cluster}"

ansible $1 -i $CLUSTER_DIR/hosts -e @$CLUSTER_DIR/config.yaml --private-key=$CLUSTER_DIR/ssh_key -a "$2" ${@:3
:99}
