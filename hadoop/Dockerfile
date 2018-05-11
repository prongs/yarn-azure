FROM ubuntu:16.04
ARG HADOOP_VERSION=2.7.6
ARG HADOOP_TAR_URL="http://www-eu.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz"
ENV HADOOP_VERSION=$HADOOP_VERSION
ENV HADOOP_TAR_URL=$HADOOP_TAR_URL
COPY install.sh /
RUN bash /install.sh
COPY configure.sh /usr/local/hadoop/configure.sh
COPY hadoop-env-with-azure.sh /usr/local/hadoop/hadoop-env-with-azure.sh
COPY etc /etc
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop/
ENV PATH "${PATH}:$HADOOP_HOME/bin/"

RUN echo '\
        . /etc/profile ; \
    ' >> /root/.profile

COPY mysql-connector-java-5.1.22.jar /mysql-connector-java-5.1.22.jar 
