for i in "$@" 
do
   DOCKER_ENV_ARGS="$DOCKER_ENV_ARGS -e $i"
done
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   DOCKER_ENV_ARGS="$DOCKER_ENV_ARGS -e YARN_HOSTNAME=docker.for.mac.localhost"
fi
cd hadoop/
docker build -t hadoop-azure-base .
cd ..
cd resourcemanager
docker build -t hadoop-azure-resourcemanager .
cd ..
cd nodemanager
docker build -t hadoop-azure-nodemanager .
docker network create docker-hadoop-network
# run the resource manager
docker run -itd --net=docker-hadoop-network -p 8088:8088 -p 8050:8050 -p 8025:8025 -p 8030:8030 -p 8141:8141 -p 8033:8033 -p 8031:8031 -p 8032:8032 -p 10020:10020 -p 19888:19888 -p 10033:10033 $DOCKER_ENV_ARGS hadoop-azure-resourcemanager
# one node manager
docker run -itd --net=docker-hadoop-network -p 45454:45454 -p 8042:8042 -p 10200:10200 -p 8188:8188 -p 8190:8190  $DOCKER_ENV_ARGS hadoop-azure-nodemanager
sleep 5
open http://localhost:8088/cluster/nodes
