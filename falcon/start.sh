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
cd $FALCON_HOME
# export FALCON_DOMAIN=falcon
bin/falcon-start

echo "Waiting falcon to launch"
while ! nc -z localhost 15443; do   
  sleep 1
done
echo "falcon launched"
# sleep 10
# export FALCON_DOMAIN=prism
bin/prism-start

echo "Waiting prism to launch"

while ! nc -z localhost 16443; do   
  sleep 1
done
echo "prism launched"
# sleep 10
echo "Submitting local cluster."
. /etc/profile
echo 'PATH="'$PATH'"' > /etc/environment
alias sudo='sudo env PATH=$PATH'
hadoop fs -mkdir /projects/falcon
hadoop fs -mkdir /projects/falcon/working
hadoop fs -mkdir /projects/falcon/staging
hadoop fs -chmod 777 /projects/falcon/staging
hadoop fs -chown -R root  /projects/falcon/

echo "Installing merlin"
cd /
userdel merlin && rm -rf /home/merlin && useradd -ms /bin/bash merlin && echo "merlin:merlin" | chpasswd && adduser merlin sudo && echo '. /etc/profile;' >> ~merlin/.profile

dpkg -i merlin*falcon*deb
MERLIN_VERSION=`ls merlin*falcon*deb  | awk -F'-' '{print $NF}' | awk -F '.deb' '{print $1}'`
# Very dirty hack for workflow memory settings:
hadoop fs -get /projects/merlin/summarization/$MERLIN_VERSION/workflow.xml  ./
sed -i 's/>512</>1536</' workflow.xml
sed -i 's/320m/1024m/' workflow.xml
sed -i 's/512m/1536m/' workflow.xml
hadoop fs -put -f /workflow.xml /projects/merlin/summarization/$MERLIN_VERSION/workflow.xml
# end hack
echo $MERLIN_VERSION
FS=$(hdfs getconf -confKey fs.defaultFS)
echo $FS
# 3 retries to register
falcon extension -register -extensionName merlin -path $FS/projects/merlin/extension || falcon extension -register -extensionName merlin -path $FS/projects/merlin/extension || falcon extension -register -extensionName merlin -path $FS/projects/merlin/extension 


echo "Waiting for oozie to launch"
while ! nc -z localhost 11000; do   
  sleep 1
done
echo "oozie launched"


# Submit initial entities
echo "Submitting entities"
for file in /entities/clusters/*xml
do
	falcon entity -type cluster -submit -file $file
done

for file in /entities/feeds/*xml
do
	falcon entity -type feed -submit -file $file
done

tail -F /usr/local/lib/falcon/logs/*
