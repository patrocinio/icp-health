k="kubectl -s localhost:8888 -n kube-system"

function obtainPod() {
	PODS=$($k get po | grep $1 | awk '{print $1}')
	echo Found $PODS
}

obtainPod $1
for p in $PODS 
do
  echo Killing Pod $p
  $k delete pod $p
done

for p in $PODS 
do
  echo Waiting for Pod to die
  obtainPod $p
  while [ "$PODS" != "" ]
  do
	  obtainPod $p
  done


done
 
