echo 'export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop/' >> /usr/local/hadoop/environs.sh
source /usr/local/hadoop/environs.sh
mkdir -p $HADOOP_HOME/etc
cp -av ../hadoop/etc/hadoop $HADOOP_HOME/etc/ || echo "unable to find ../hadoop/etc/hadoop"
cp -av etc/hadoop $HADOOP_HOME/etc/ || echo "unable to find ./etc/hadoop"
if [ -z "$HOSTNAME" ]; then
	HOSTNAME=`hostname`
fi
# core-site changes
sed -i "s|AZURE_BLOB_CONTAINER|$AZURE_BLOB_CONTAINER|" $HADOOP_CONF_DIR/core-site.xml
sed -i "s|AZURE_BLOB_ENDPOINT|$AZURE_BLOB_ENDPOINT|" $HADOOP_CONF_DIR/core-site.xml
sed -i "s|AZURE_FS_KEY|$AZURE_FS_KEY|" $HADOOP_CONF_DIR/core-site.xml
sed -i "s|AZURE_FS_PROTOCOL|$AZURE_FS_PROTOCOL|" $HADOOP_CONF_DIR/core-site.xml
# # yarn-site
sed -i s/YARN_HOSTNAME/$YARN_HOSTNAME/ $HADOOP_CONF_DIR/yarn-site.xml
sed -i s/HOSTNAME/$HOSTNAME/ $HADOOP_CONF_DIR/yarn-site.xml
# # mapred-site
sed -i s/YARN_HOSTNAME/$YARN_HOSTNAME/ $HADOOP_CONF_DIR/mapred-site.xml
sed -i s/HOSTNAME/$HOSTNAME/ $HADOOP_CONF_DIR/mapred-site.xml

# # METRICS
if [ -n "$GRAPHITE_HOST" ]; then
	sed 's/GRAPHITE_HOST/'$GRAPHITE_HOST'/; s/GRAPHITE_PORT/'$GRAPHITE_PORT'/' $HADOOP_CONF_DIR/hadoop-metrics2.graphite.properties > $HADOOP_CONF_DIR/hadoop-metrics2.properties
fi
# # azure jars
cat $HADOOP_HOME/hadoop-env-with-azure.sh >> $HADOOP_CONF_DIR/hadoop-env.sh
echo "127.0.0.1 `hostname`" >> /etc/hosts
