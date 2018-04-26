FROM hadoop-azure-base:latest
ARG OOZIE_DEB_URL
ENV OOZIE_DEB_URL $OOZIE_DEB_URL
ENV OOZIE_CURRENT=/usr/local/oozie-current/
RUN useradd -ms /bin/bash oozie
RUN mkdir -p /etc/default/
COPY oozie_install_defaults.sh /etc/default/oozie
COPY install.sh /
RUN bash -x /install.sh
COPY configure.sh $OOZIE_CURRENT/
COPY start.sh /
ENTRYPOINT bash -x /start.sh
