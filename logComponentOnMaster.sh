k="kubectl -s localhost:8888 -n kube-system"
PODS=$($k get po | grep $1 | awk '{print $1}')
echo Found $PODS

for p in $PODS
do
	echo Pod: $p
	while [ "$($k get po $p | grep -v NAME | awk '{print $3}')" == "ContainerCreating" ]
	do
		sleep 1
	done

	$kß logs -f $p | tee /tmp/$p &
done
