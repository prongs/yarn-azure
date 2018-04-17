apt-get -y update
DEPLOYMENT_METHOD=$1 # docker/native
shift
if [ $DEPLOYMENT_METHOD == "docker" ]; then
	apt-get -y install docker.io
	shift
	for i in "$@"
	do
   		DOCKER_ENV_ARGS="$DOCKER_ENV_ARGS -e $i"
   		eval "export $i"
	done
	IMAGE="hadoop-azure-"$1
	docker login $DOCKER_REGISTRY_URL -u DOCKER_REGISTRY_USERNAME -p DOCKER_REGISTRY_PASSWORD

	docker pull $IMAGE
	docker run -itd $DOCKER_ENV_ARGS $IMAGE
else
	apt-get -y install -y git wget curl telnet
	git clone https://github.com/prongs/yarn-azure.git
	cd yarn-azure
	bash run.sh $@
fi