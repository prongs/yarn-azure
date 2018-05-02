FROM hadoop-azure-base:latest
ARG OOZIE_DEB_URL
ENV OOZIE_DEB_URL $OOZIE_DEB_URL
ENV OOZIE_CURRENT=/usr/local/oozie-current/
RUN useradd -ms /bin/bash oozie
RUN mkdir -p /etc/default/
COPY oozie_install_defaults.sh /etc/default/oozie
COPY install.sh /
RUN bash -x /install.sh
RUN apt-get -y install mysql-client
COPY mysql-connector-java-5.1.22.jar $OOZIE_CURRENT/libext/mysql-connector-java-5.1.22.jar 
RUN cd $OOZIE_CURRENT && sudo -u oozie $OOZIE_CURRENT/bin/oozie-setup.sh prepare-war
COPY oozie-site.xml $OOZIE_CURRENT/conf/oozie-site.xml
COPY configure.sh $OOZIE_CURRENT/
COPY start.sh /
ENTRYPOINT bash -x /start.sh
