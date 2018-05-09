apt-get -y update
DEPLOYMENT_METHOD=$1 # docker/native
shift
if [ $DEPLOYMENT_METHOD == "docker" ]; then
	apt-get -y update && apt-get -y install docker.io
	declare -a images
	for i in "$@"
	do
		if [[ $i != *"="* ]]; then 
   			images=("${images[@]}" "hadoop-azure-$i")
		else
			DOCKER_ENV_ARGS="$DOCKER_ENV_ARGS -e $i"
   			eval "export $i"
		fi
	done
	docker login $DOCKER_REGISTRY_URL -u $DOCKER_REGISTRY_USERNAME -p $DOCKER_REGISTRY_PASSWORD
	HOSTNAME=`hostname`
	echo "Images to pull: ${images[@]}"
	echo $images
	for IMAGE in "${images[@]}"
	do
		echo "Downloading $IMAGE"
		docker pull $DOCKER_REGISTRY_URL/$IMAGE
		echo "Downloaded $IMAGE"
		docker run --net=host -itd $DOCKER_ENV_ARGS -e HOSTNAME=$HOSTNAME $DOCKER_REGISTRY_URL/$IMAGE
		echo "Started image $IMAGE"
	done
else
	apt-get -y install -y git wget curl telnet
	git clone https://github.com/prongs/yarn-azure.git
	git checkout master
	cd yarn-azure
	./run.sh $@
fi