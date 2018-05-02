source /usr/local/hadoop/environs.sh
$HADOOP_HOME/configure.sh # running outside docker. 
./configure.sh
$FALCON_HOME/bin/service-start.sh falcon
$FALCON_HOME/bin/service-stop.sh falcon
rm -rf $FALCON_HOME/server/webapp/falcon/WEB-INF/lib/mysql-connector-java-*jar
cp $FALCON_HOME/client/lib/mysql-connector-java-5.1.22.jar $FALCON_HOME/server/webapp/falcon/WEB-INF/lib/mysql-connector-java-5.1.22.jar
$FALCON_HOME/bin/service-start.sh falcon
tail -F /usr/local/lib/falcon/logs/*
