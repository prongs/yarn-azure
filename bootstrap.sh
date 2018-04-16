apt-get -y update
DEPLOYMENT_METHOD=$1 # docker/native
shift
if [ $DEPLOYMENT_METHOD == "docker" ] then;
	apt-get -y install docker
	IMAGE=$1
	shift
	docker pull $IMAGE
else
	apt-get -y install -y git wget curl telnet
	git clone https://github.com/prongs/yarn-azure.git
	cd yarn-azure
	bash run.sh $@
fi