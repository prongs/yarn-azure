source /usr/local/hadoop/environs.sh

bash $HADOOP_HOME/configure.sh # running outside docker. 
echo "Starting Resourcemanager"
$HADOOP_HOME/sbin/yarn-daemon.sh start resourcemanager

echo "Starting Job History Server"
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver

# Keep up
tail -F /dev/null
