useradd -ms /bin/bash oozie
echo '\
        . /etc/profile ; \
    ' >> ~oozie/.profile
mkdir -p /etc/default/
wget $OOZIE_DEB_URL || exit 127
# dpkg -i oozie*deb
# rm -rf *deb
# echo 'export PATH=$PATH:$OOZIE_CURRENT/bin' >> /etc/profile
# cp /mysql-connector-java-5.1.22.jar $OOZIE_CURRENT/libext/mysql-connector-java-5.1.22.jar 
# cd $OOZIE_CURRENT && sudo -u oozie $OOZIE_CURRENT/bin/oozie-setup.sh prepare-war
