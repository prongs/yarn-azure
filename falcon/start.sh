source /usr/local/hadoop/environs.sh
$HADOOP_HOME/configure.sh # running outside docker. 
./configure.sh
$FALCON_HOME/bin/falcon-start
$FALCON_HOME/bin/falcon-stop
$FALCON_HOME/bin/prism-start
$FALCON_HOME/bin/prism-stop
# Update mysql connector jar for ssl
rm -rf $FALCON_HOME/server/webapp/falcon/WEB-INF/lib/mysql-connector-java-*jar
rm -rf $FALCON_HOME/server/webapp/prism/WEB-INF/lib/mysql-connector-java-*jar
cp $FALCON_HOME/client/lib/mysql-connector-java-5.1.22.jar $FALCON_HOME/server/webapp/falcon/WEB-INF/lib/mysql-connector-java-5.1.22.jar
cp $FALCON_HOME/client/lib/mysql-connector-java-5.1.22.jar $FALCON_HOME/server/webapp/prism/WEB-INF/lib/mysql-connector-java-5.1.22.jar
$FALCON_HOME/bin/falcon-start
$FALCON_HOME/bin/prism-start
sleep 5
echo "Submitting local cluster."
falcon entity -type cluster -submit -file /cluster-local.xml
tail -F /usr/local/lib/falcon/logs/*
