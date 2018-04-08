echo Checking health of Pods

FILE=/tmp/gp
UNHEALTHY=/tmp/unhealthy

kubectl -s localhost:8888 get pods --all-namespaces > $FILE

COUNT=$(wc -l $FILE)

echo === Number of Pods: $COUNT

echo === Pods that are not in Running state

grep -v Running $FILE | tail +2 | tee $UNHEALTHY

while read -r pod
do
	echo $pod | awk '{print $2}'
done < $UNHEALTHY


