if [[ $1 != *"="* ]]; then 
	DOCKER_REGISTRY_URL=$1
	DOCKER_REGISTRY_LOGIN_ARGS=$DOCKER_REGISTRY_URL
	shift
	if [[ $1 != *"="* ]]; then 
		DOCKER_REGISTRY_LOGIN_ARGS="$DOCKER_REGISTRY_LOGIN_ARGS -u $1"
		shift
	fi
	if [[ $1 != *"="* ]]; then 
		DOCKER_REGISTRY_LOGIN_ARGS="$DOCKER_REGISTRY_LOGIN_ARGS -p $1"
		shift
	fi
	docker login $DOCKER_REGISTRY_LOGIN_ARGS
fi
docker_push() {
	if [ -n "$DOCKER_REGISTRY_URL" ]; then 
		docker tag $1 $DOCKER_REGISTRY_URL/$1
		docker push $DOCKER_REGISTRY_URL/$1
	fi
}
for i in "$@"
do
   DOCKER_BUILD_ARGS="$DOCKER_BUILD_ARGS --build-arg $i"
done
echo "build args: $DOCKER_BUILD_ARGS"
docker build $DOCKER_BUILD_ARGS -t hadoop-azure-base hadoop
docker_push hadoop-azure-base &
docker build $DOCKER_BUILD_ARGS -t hadoop-azure-resourcemanager resourcemanager
docker build $DOCKER_BUILD_ARGS -t hadoop-azure-nodemanager nodemanager
# wait
# docker_push hadoop-azure-resourcemanager &
# docker_push hadoop-azure-nodemanager &
# wait

docker build $DOCKER_BUILD_ARGS -t hadoop-oozie oozie
docker_push hadoop-oozie

#docker build $DOCKER_BUILD_ARGS -t hadoop-falcon falcon
#docker_push hadoop-falcon
