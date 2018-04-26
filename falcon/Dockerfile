FROM hadoop-oozie:latest
ARG FALCON_DEB_URL
RUN wget $FALCON_DEB_URL
RUN dpkg -i falcon*deb
RUN useradd -ms /bin/bash oozie
