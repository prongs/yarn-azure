export OOZIE_CURRENT=/usr/local/oozie-current/
export OOZIE_BASE=/usr/local/oozie/
export EXTJS_URL=
export MYSQL_CONNECTOR_JAR=
export NAMENODE=`hdfs getconf -confKey fs.defaultFS`
export HADOOP_CONF=$HADOOP_HOME/etc/hadoop/
export HADOOP_CLIENT=$HADOOP_HOME/share/hadoop/common/
export HADOOP_HDFS_CLIENT=$HADOOP_HOME/share/hadoop/hdfs/
export HADOOP_MAPREDUCE_CLIENT=$HADOOP_HOME/share/hadoop/mapreduce/
export HADOOP_YARN_CLIENT=$HADOOP_HOME/share/hadoop/yarn/
export ZOOKEEPER_CLIENT=$HADOOP_HOME #dummy, just to keep oozie happy
export DEPLOYMENT_MODE=FULL
export DB_FLAG=TRUE
