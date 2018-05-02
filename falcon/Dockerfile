FROM hadoop-azure-base:latest
ARG FALCON_DEB_URL
ENV FALCON_DEB_URL $FALCON_DEB_URL
ARG MERLIN_DEB_URL
ENV MERLIN_DEB_URL $MERLIN_DEB_URL
ENV FALCON_HOME /usr/local/lib/falcon
COPY install.sh /
RUN bash -x /install.sh
RUN wget $MERLIN_DEB_URL
RUN dpkg -i merlin*falcon*deb
RUN rm -rf merlin*falcon*deb

COPY statestore.properties $FALCON_HOME/conf/
COPY statestore.credentials $FALCON_HOME/conf/
COPY configure.sh /
COPY start.sh /
# RUN rm -rf $FALCON_HOME/server/webapp/falcon/WEB-INF/lib/mysql-connector-java-*.jar
RUN rm -rf $FALCON_HOME/client/lib/mysql-connector-java-*jar
# COPY mysql-connector-java-5.1.22.jar $FALCON_HOME/server/webapp/falcon/WEB-INF/lib/mysql-connector-java-5.1.22.jar
COPY mysql-connector-java-5.1.22.jar $FALCON_HOME/client/lib/mysql-connector-java-5.1.22.jar
ENV FALCON_DOMAIN production
ENTRYPOINT bash -x /start.sh
