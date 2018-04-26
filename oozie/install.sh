wget $OOZIE_DEB_URL || exit 127
dpkg -i oozie*deb
rm -rf *deb
echo 'export PATH=$PATH:$OOZIE_CURRENT/bin' >> ~/.bashrc