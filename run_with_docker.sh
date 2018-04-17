for i in "$@"
do
   DOCKER_ENV_ARGS="$DOCKER_ENV_ARGS -e $i"
   eval "export $i"
done
IMAGE="hadoop-azure-"$1
docker login $DOCKER_REGISTRY_URL -u DOCKER_REGISTRY_USERNAME -p DOCKER_REGISTRY_PASSWORD

docker pull $IMAGE
docker run -itd $DOCKER_ENV_ARGS $IMAGE
