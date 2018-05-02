sed -i 's/MYSQL_HOST/'$MYSQL_HOST'/' $FALCON_HOME/conf/statestore.properties
if [ -z "$MYSQL_PORT" ]; then
	MYSQL_PORT=3306
fi
sed -i 's/MYSQL_HOST/'$MYSQL_HOST'/' $FALCON_HOME/conf/statestore.properties
sed -i 's/MYSQL_PORT/'$MYSQL_PORT'/' $FALCON_HOME/conf/statestore.properties

sed -i 's/FALCON_DB_USERNAME/'$FALCON_DB_USERNAME'/' $FALCON_HOME/conf/statestore.credentials
sed -i 's/FALCON_DB_USERNAME/'$FALCON_DB_USERNAME'/' $FALCON_HOME/conf/statestore.properties
sed -i 's/FALCON_DB_PASSWORD/'$FALCON_DB_PASSWORD'/' $FALCON_HOME/conf/statestore.credentials
sed -i 's/FALCON_DB_PASSWORD/'$FALCON_DB_PASSWORD'/' $FALCON_HOME/conf/statestore.properties
cat $FALCON_HOME/conf/statestore.properties
cat $FALCON_HOME/conf/statestore.credentials
chmod 400 /usr/local/lib/falcon/conf/statestore.credentials
rm -rf $FALCON_HOME/server/webapp/falcon/WEB-INF/lib/mysql-connector-java-*jar
cp $FALCON_HOME/client/lib/mysql-connector-java-5.1.22.jar $FALCON_HOME/server/webapp/falcon/WEB-INF/lib/mysql-connector-java-5.1.22.jar

echo "CREATE DATABASE IF NOT EXISTS falcon;" > create.sql
echo "before mysql"
mysql -h $MYSQL_HOST --port=$MYSQL_PORT --user=$FALCON_DB_USERNAME --password=$FALCON_DB_PASSWORD < create.sql
echo "after mysql"
