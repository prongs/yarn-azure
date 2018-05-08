FROM hadoop-azure-base:latest
ARG FALCON_DEB_URL
ENV FALCON_DEB_URL $FALCON_DEB_URL
ARG MERLIN_DEB_URL
ENV MERLIN_DEB_URL $MERLIN_DEB_URL
ENV FALCON_HOME /usr/local/lib/falcon
COPY install.sh /
RUN bash -x /install.sh
RUN wget $MERLIN_DEB_URL

COPY statestore.properties $FALCON_HOME/conf/
COPY statestore.credentials $FALCON_HOME/conf/
COPY startup.properties $FALCON_HOME/conf/
COPY configure.sh /
COPY cluster-local.xml /cluster-local.xml
COPY start.sh /
# RUN rm -rf $FALCON_HOME/server/webapp/falcon/WEB-INF/lib/mysql-connector-java-*.jar
RUN rm -rf $FALCON_HOME/client/lib/mysql-connector-java-*jar
COPY mysql-connector-java-5.1.22.jar $FALCON_HOME/client/lib/mysql-connector-java-5.1.22.jar

ENV FALCON_URL https://localhost:16443/
ENV PATH "$PATH:$FALCON_HOME/bin/"
COPY sudoers /etc/sudoers
ENTRYPOINT bash -x /start.sh
