USER=$1
BOOT=$2
CLUSTER_DIR=$3
echo Copying files from Boot node $BOOT, directory $CLUSTER_DIR using user $USER to $ICP_ENVIRONMENT

echo Copying files
scp $USER@$BOOT:$CLUSTER_DIR/{config.yaml,hosts,ssh_key} $ICP_ENVIRONMENT

