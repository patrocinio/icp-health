FILE=/tmp/gp

function obtainPods {
	echo === Checking health of Pods

	kubectl get pods --all-namespaces > $FILE
}

function numberOfPods {
	COUNT=$(wc -l $FILE)

	echo === Number of Pods: $COUNT

}

function podsNotRunning {
	echo === Pods that are not in Running state

	grep -v Running $FILE
}

function restartedPods {
	echo === Pods with higher number of restarts
	while read -r pod
	do
		RESTART=$(echo $pod | awk '{print $5}')
		if (( $RESTART > 10 ));
		then
			echo $pod
		fi
	done < $FILE

}

function getMasterIP {
	kubectl get nodes -o json | \
	jq '.items[].metadata | select (.labels.role == "master") | .name' \
	| tr -d '"'
}

function uiStatus {
	echo === Checking health of the UI
	ip=$(getMasterIP)
	status=$(curl -s -o /dev/null --insecure -I -w "%{http_code}" \
		https://$ip:8443/console/welcome)

	echo UI status: $status
}


obtainPods
numberOfPods
podsNotRunning
restartedPods
uiStatus
