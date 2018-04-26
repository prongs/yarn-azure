FROM ubuntu:16.04
ARG HADOOP_VERSION=2.7.6
ARG HADOOP_TAR_URL="http://www-eu.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz"
COPY configure.sh /
COPY hadoop-env-with-azure.sh /
COPY install.sh /
ENV HADOOP_VERSION=$HADOOP_VERSION
ENV HADOOP_TAR_URL=$HADOOP_TAR_URL
RUN bash /install.sh
COPY etc /etc
RUN echo 'source /usr/local/hadoop/environs.sh' >> ~/.bashrc
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop/
ENV PATH "${PATH}:$HADOOP_HOME/bin/"
