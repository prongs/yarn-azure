apt-get -y update
apt-get -y install -y --no-install-recommends \
    apt-transport-https \
    curl wget tar \
    software-properties-common

install_java() {
	# install java
	add-apt-repository -y ppa:openjdk-r/ppa
	apt-get -y update
	apt-get -y install -y openjdk-8-jdk 
	apt-get -y install -y zip unzip telnet sudo rsync
	apt-get -y install -y mysql-client
	apt-get -y install -y vim
}
install_hadoop() {
	if [ -z "$HADOOP_VERSION" ]; then 
		HADOOP_VERSION="2.7.6"
	fi
	if [ -z "$HADOOP_TAR_URL" ]; then
		HADOOP_TAR_URL="http://www-eu.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz"
	fi
	wget $HADOOP_TAR_URL
	tar -xvzf hadoop-$HADOOP_VERSION.tar.gz -C /usr/local/
	rm -rf hadoop-$HADOOP_VERSION.tar.gz 
	cd /usr/local
	ln -s ./hadoop-$HADOOP_VERSION hadoop
	cd -
}
install_java &
install_hadoop
wait

cp configure.sh /usr/local/hadoop/
cp hadoop-env-with-azure.sh /usr/local/hadoop/
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /usr/local/hadoop/environs.sh
echo 'export HADOOP_HOME=/usr/local/hadoop/' >> /usr/local/hadoop/environs.sh
echo 'export PATH=$PATH:/usr/local/hadoop/bin/' >> /usr/local/hadoop/environs.sh
source /usr/local/hadoop/environs.sh
echo 'source /usr/local/hadoop/environs.sh' >> /etc/profile
java -version
