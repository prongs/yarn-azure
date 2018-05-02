cat $OOZIE_CURRENT/conf/oozie-site.xml
sed -i 's/MYSQL_HOST/'$MYSQL_HOST'/' $OOZIE_CURRENT/conf/oozie-site.xml
if [ -z "$MYSQL_PORT" ]; then
	MYSQL_PORT=3306
fi
sed -i 's/MYSQL_PORT/'$MYSQL_PORT'/' $OOZIE_CURRENT/conf/oozie-site.xml

sed -i 's/OOZIE_DB_USERNAME/'$OOZIE_DB_USERNAME'/' $OOZIE_CURRENT/conf/oozie-site.xml
sed -i 's/OOZIE_DB_PASSWORD/'$OOZIE_DB_PASSWORD'/' $OOZIE_CURRENT/conf/oozie-site.xml
echo "CREATE DATABASE IF NOT EXISTS oozie;" > create.sql
echo "before mysql"
mysql -h $MYSQL_HOST --port=$MYSQL_PORT --user=$OOZIE_DB_USERNAME --password=$OOZIE_DB_PASSWORD < create.sql
echo "after mysql"
sudo -u oozie $OOZIE_CURRENT/bin/ooziedb.sh create -sqlfile $OOZIE_CURRENT/oozie.sql -run
echo "waah"