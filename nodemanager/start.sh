source /usr/local/hadoop/environs.sh
chmod +x $HADOOP_HOME/configure.sh
$HADOOP_HOME/configure.sh # running outside docker. 
echo "Starting Nodemanager"
$HADOOP_HOME/sbin/yarn-daemon.sh start nodemanager
