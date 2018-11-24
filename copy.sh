SOURCE=$1
DEST=$2


echo Copying file $SOURCE to $DEST
for h in `cat $ICP_ENVIRONMENT/hosts`
do
	if [[ $h =~ "[" ]]
	then
		echo Skipping $h
	else
		echo Copying to $h
	fi
done