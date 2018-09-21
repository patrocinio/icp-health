NODE=$1
SERVICE=$2

echo Stopping service $SERVICE in $NODE nodes
ansible $NODE -i $ICP_ENVIRONMENT/hosts -e @$ICP_ENVIRONMENT/config.yaml --private-key=$ICP_ENVIRONMENT/ssh_key -m service -a "name=$SERVICE state=stopped"