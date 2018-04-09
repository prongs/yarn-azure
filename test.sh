for i in "$@" 
do
   DOCKER_ENV_ARGS="$DOCKER_ENV_ARGS -e $i"
done
cd hadoop/
docker build -t hadoop-azure-base .
cd ..
cd resourcemanager
docker build -t hadoop-azure-resourcemanager .
cd ..
cd nodemanager
docker build -t hadoop-azure-nodemanager .
docker run -itd --net=host -p 8088:8088 -p 8050:8050 -p 8025:8025 -p 8030:8030 $DOCKER_ENV_ARGS hadoop-azure-resourcemanager
