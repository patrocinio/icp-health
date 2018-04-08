echo Checking health of Pods

FILE=/tmp/gp
UNHEALTHY=/tmp/unhealthy
k="kubectl -s localhost:8888 -n kube-system"

$k get pods > $FILE

COUNT=$(wc -l $FILE)

echo === Number of Pods: $COUNT

echo === Pods that are not in Running state

grep -v Running $FILE | tail +2 | tee $UNHEALTHY

while read -r pod
do
	POD_NAME=$(echo $pod | awk '{print $1}')
	echo Restarting $POD_NAME
	$k delete pod $POD_NAME
done < $UNHEALTHY


