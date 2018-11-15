FILE=$1
DEST=$2

: "${ICP_ENVIRONMENT:=/opt/ibm-cloud-private-3.1.0/cluster}"

for host in `cat $ICP_ENVIRONMENT/hosts`
do
	if [[ $host != \[* ]]
	then
    	echo Copying to $host
    	scp $FILE root@$host:$DEST
    fi
done
