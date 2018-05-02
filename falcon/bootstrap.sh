apt-get -y install docker.io
shift
for i in "$@"
do
		DOCKER_ENV_ARGS="$DOCKER_ENV_ARGS -e $i"
		eval "export $i"
done
HOSTNAME=`hostname`
docker login $DOCKER_REGISTRY_URL -u $DOCKER_REGISTRY_USERNAME -p $DOCKER_REGISTRY_PASSWORD
docker pull $DOCKER_REGISTRY_URL/hadoop-oozie
docker run --net=host -itd $DOCKER_ENV_ARGS -e HOSTNAME=$HOSTNAME $DOCKER_REGISTRY_URL/hadoop-oozie
docker pull $DOCKER_REGISTRY_URL/hadoop-falcon
docker run --net=host -itd $DOCKER_ENV_ARGS -e HOSTNAME=$HOSTNAME $DOCKER_REGISTRY_URL/hadoop-falcon
