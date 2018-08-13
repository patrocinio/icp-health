## --------------------------------------------------------------------------------------------------
## ICP login script to authenticate and connect to and IBM Cloud Private (ICP) environment
## Provided by IBM Cloud Private Center of Competency team  
## --------------------------------------------------------------------------------------------------

#ICPHOST=https://169.63.82.132
ICPHOST=https://mycluster.icp
ICPUSER=admin
ICPPASSWORD=admin
ICPCLUSTER=mycluster.icp
ICPNAMESPACE=kube-system

## get ICP host url 
read -p 'ICP Host url: ' hostvar
if [ -z "$hostvar" ]
then
      echo "- Using default host: " $ICPHOST
else
      ICPHOST=$hostvar
fi

if [[ $ICPHOST == https://* ]]
then
      echo 
else
      echo "ERROR: ICP Host must start with https:// followed with IP or valid url name"
      exit 1 # terminate and indicate error
fi

## get ICP cluster 
read -p 'ICP Cluster (mycluster.icp): ' clustervar 
if [ -z "$clustervar" ]
then
      echo "- Using default cluster: " $ICPCLUSTER
      echo
else
      ICPCLUSTER=$clustervar
fi

## get ICP cluster namespace 
read -p 'Namespace (kube-system): ' namespacevar
if [ -z "$namespacevar" ]
then
      echo "- Using default namespace: " $ICPNAMESPACE
      echo
else
      ICPUSER=$namespacevar
fi

## get user name
read -p 'Username (admin): ' uservar
if [ -z "$uservar" ]
then
      echo "- Using default user: " $ICPUSER
      echo
else
      ICPUSER=$uservar
fi

## get user password
read -sp 'Password (********): ' passvar
if [ -z "$passvar" ]
then
      echo
      echo "- Using default password"
      echo
else
      ICPPASSWORD=$passvar
fi

echo Retrieving security token for user: $ICPUSER at host: $ICPHOST
## get the id token 

TOKEN=$(curl -s -X POST $ICPHOST:8443/idprovider/v1/auth/identitytoken -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" -d "grant_type=password&username=$ICPUSER&password=$ICPPASSWORD&scope=openid%20email%20profile" --insecure | jq --raw-output .id_token) 

echo token is  $TOKEN

echo 
echo Setting kubectl enviroment
echo
## execute kubectl commands to connect to ICP environment
kubectl config set-cluster $ICPCLUSTER --server=$ICPHOST:8001 --insecure-skip-tls-verify=true
kubectl config set-context $ICPCLUSTER-context --cluster=mycluster.icp
kubectl config set-credentials $ICPUSER --token=$TOKEN
kubectl config set-context $ICPCLUSTER-context --user=$ICPUSER --namespace=$ICPNAMESPACE
kubectl config use-context $ICPCLUSTER-context
echo
echo "Try kubectl get pods"
echo
