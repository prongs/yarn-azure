echo "export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop/" >> /usr/local/hadoop/environs.sh
source /usr/local/hadoop/environs.sh
mkdir -p $HADOOP_HOME/etc
cp -av etc/hadoop $HADOOP_HOME/etc/
# core-site changes
sed "s|AZURE_HADOOP_FS|$AZURE_HADOOP_FS|" $HADOOP_CONF_DIR/core-site.xml > $HADOOP_CONF_DIR/core-site.xml.1
mv $HADOOP_CONF_DIR/core-site.xml.1 $HADOOP_CONF_DIR/core-site.xml
sed "s|AZURE_FS_KEY|$AZURE_FS_KEY|" $HADOOP_CONF_DIR/core-site.xml > $HADOOP_CONF_DIR/core-site.xml.1
mv $HADOOP_CONF_DIR/core-site.xml.1 $HADOOP_CONF_DIR/core-site.xml
# # yarn-site
sed s/YARN_HOSTNAME/$YARN_HOSTNAME/ $HADOOP_CONF_DIR/yarn-site.xml > $HADOOP_CONF_DIR/yarn-site.xml.1
mv $HADOOP_CONF_DIR/yarn-site.xml.1 $HADOOP_CONF_DIR/yarn-site.xml
# # mapred-site
sed s/YARN_HOSTNAME/$YARN_HOSTNAME/ $HADOOP_CONF_DIR/mapred-site.xml > $HADOOP_CONF_DIR/mapred-site.xml.1
mv $HADOOP_CONF_DIR/mapred-site.xml.1 $HADOOP_CONF_DIR/mapred-site.xml
# # azure jars
cat $HADOOP_HOME/hadoop-env-with-azure.sh >> $HADOOP_CONF_DIR/hadoop-env.sh
HOSTNAME=`hostname`
echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
