apt-get -y update
apt-get -y install -y git
git clone https://github.com/prongs/yarn-azure.git
cd yarn-azure
bash run.sh $@
