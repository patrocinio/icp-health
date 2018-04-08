echo Checking health of Pods

FILE=/tmp/gp
UNHEALTHY=/tmp/unhealthy
alias k="kubectl -s localhost:8888"

k get pods --all-namespaces > $FILE

COUNT=$(wc -l $FILE)

echo === Number of Pods: $COUNT

echo === Pods that are not in Running state

grep -v Running $FILE | tail +2 | tee $UNHEALTHY

while read -r pod
do
	POD_NAME=$(echo $pod | awk '{print $2}')
	echo Restarting $POD_NAME
	k delete pod $POD_NAME
done < $UNHEALTHY


