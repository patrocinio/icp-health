echo Checking health of Pods

FILE=/tmp/gp

kubectl -s localhost:8888 get pods --all-namespaces > $FILE

COUNT=$(wc -l $FILE)

echo === Number of Pods: $COUNT

echo === Pods that are not in Running state

grep -v Running $FILE

echo === Pods with higher number of restarts
while read -r pod
do
	RESTART=$(echo $pod | awk '{print $5}')
	if (( $RESTART > 10 ));
	then
		echo $pod
	fi
done < $FILE
