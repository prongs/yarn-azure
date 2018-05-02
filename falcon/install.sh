useradd -ms /bin/bash falcon
useradd -ms /bin/bash merlin

wget $FALCON_DEB_URL
dpkg -i *falcon*deb
rm -rf falcon*deb
if [ -z "$FALCON_HOME" ]; then
	FALCON_HOME="/usr/local/lib/falcon"
fi
ln -s /usr/local/lib/apache-*-falcon $FALCON_HOME
echo 'export PATH=$PATH:$FALCON_HOME/bin/' > /etc/profile
