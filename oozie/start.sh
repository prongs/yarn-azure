source /usr/local/hadoop/environs.sh
chmod +x $HADOOP_HOME/configure.sh
$HADOOP_HOME/configure.sh # running outside docker. 

chmod +x $OOZIE_CURRENT/configure.sh
$OOZIE_CURRENT/configure.sh # running outside docker. 
echo "Starting Oozie"
rm -rf $OOZIE_CURRENT/conf/hadoop-conf
ls -R $OOZIE_CURRENT
ln -s $HADOOP_HOME/etc/hadoop $OOZIE_CURRENT/conf/hadoop-conf
hadoop fs -mkdir -p /user/root/share/lib
oozie-run.sh 
