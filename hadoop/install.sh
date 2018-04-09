apt-get -y update
apt-get -y install -y --no-install-recommends \
    apt-transport-https \
    curl wget telnet tar sudo rsync \
    software-properties-common

install_java() {
	# install java
	add-apt-repository -y ppa:openjdk-r/ppa
	apt-get -y update
	apt-get -y install -y openjdk-8-jdk
}
install_hadoop() {
	wget http://www-eu.apache.org/dist/hadoop/common/hadoop-2.7.5/hadoop-2.7.5.tar.gz
	tar -xvzf hadoop-2.7.5.tar.gz -C /usr/local/
	rm -rf hadoop-2.7.5.tar.gz 
	cd /usr/local
	ln -s ./hadoop-2.7.5 hadoop
	cd -
}
install_java &
install_hadoop
wait
cp configure.sh /usr/local/hadoop/
cp hadoop-env-with-azure.sh /usr/local/hadoop/
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /usr/local/hadoop/environs.sh
echo "export HADOOP_HOME=/usr/local/hadoop/" >> /usr/local/hadoop/environs.sh
echo "export PATH=$PATH:$HADOOP_HOME/bin/" >> /usr/local/hadoop/environs.sh
source /usr/local/hadoop/environs.sh
echo "source /usr/local/hadoop/environs.sh" >> ~/.bashrc