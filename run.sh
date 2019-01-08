# $1 host-pattern
# $2 command

: "${ICP_ENVIRONMENT:=/opt/icp-3.1.1/cluster}"

export ANSIBLE_HOST_KEY_CHECKING=False

ansible $1 -i $ICP_ENVIRONMENT/hosts -e @$ICP_ENVIRONMENT/config.yaml --private-key=$ICP_ENVIRONMENT/ssh_key -a "$2" ${@:3
:99}
