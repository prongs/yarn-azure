source /usr/local/hadoop/environs.sh

bash $HADOOP_HOME/configure.sh # running outside docker. 
echo "Starting Nodemanager"
$HADOOP_HOME/sbin/yarn-daemon.sh start nodemanager
