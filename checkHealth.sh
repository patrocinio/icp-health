FILE=/tmp/gp

function checkNodes {
	echo === Checking nodes that are not ready
	kubectl get nodes --no-headers=true | grep -v -w Ready
}

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

	grep -v Running $FILE | grep -v Completed
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
	| tr -d '"' | head -1
}

function installJq {
	echo Installing jq...
	sudo apt-get install -y jq
}

function uiStatus {
	echo === Checking health of the UI
	ip=$(getMasterIP)
	echo Master IP: $ip
	status=$(curl -s -o /dev/null --insecure -I -w "%{http_code}" \
		https://$ip:8443/console/welcome)

	echo UI status: $status
}

function topNodes {
	echo === Resource utilization
	kubectl top nodes
} 

checkNodes
obtainPods
numberOfPods
podsNotRunning
restartedPods
installJq
uiStatus
topNodes
