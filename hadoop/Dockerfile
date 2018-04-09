FROM ubuntu:16.04
COPY configure.sh /
COPY hadoop-env-with-azure.sh /
COPY install.sh /
RUN bash /install.sh
COPY etc /etc
