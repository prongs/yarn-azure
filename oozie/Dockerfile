FROM hadoop-azure-base:latest
ARG OOZIE_DEB_URL
ENV OOZIE_DEB_URL $OOZIE_DEB_URL
ENV OOZIE_CURRENT=/usr/local/oozie-current/
COPY install.sh /
RUN bash -x /install.sh
COPY oozie_install_defaults.sh /etc/default/oozie
COPY oozie-site.xml /
COPY configure.sh /
COPY start.sh /
ENTRYPOINT bash -x /start.sh
