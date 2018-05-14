source /usr/local/hadoop/environs.sh
chmod +x $HADOOP_HOME/configure.sh
$HADOOP_HOME/configure.sh # running outside docker. 
# installation steps moved to here

dpkg -i oozie*deb
# rm -rf *deb
echo 'export PATH=$PATH:$OOZIE_CURRENT/bin' >> /etc/profile
cp /mysql-connector-java-5.1.22.jar $OOZIE_CURRENT/libext/mysql-connector-java-5.1.22.jar 
cp /configure.sh $OOZIE_CURRENT/
cp /oozie-site.xml $OOZIE_CURRENT/conf/
# The following is needed to update mysql connector jar in the war lib. 
cd $OOZIE_CURRENT && sudo -u oozie $OOZIE_CURRENT/bin/oozie-setup.sh prepare-war

chmod +x $OOZIE_CURRENT/configure.sh
bash -x $OOZIE_CURRENT/configure.sh # running outside docker. 
echo "Starting Oozie"

rm -rf $OOZIE_CURRENT/conf/hadoop-conf
ls -R $OOZIE_CURRENT
ln -s $HADOOP_HOME/etc/hadoop $OOZIE_CURRENT/conf/hadoop-conf
hadoop fs -mkdir -p /user/root/share/lib
echo $PATH
sudo -u oozie bash -x $OOZIE_CURRENT/bin/oozied.sh start
tail -F $OOZIE_CURRENT/logs/*
