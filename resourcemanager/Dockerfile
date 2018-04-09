FROM hadoop-azure-base:latest
COPY etc /etc
COPY start.sh /
EXPOSE 8088 8050 8025 8030 8141 8033 8031 8032 10020 19888 10033
ENTRYPOINT ["bash", "/start.sh"]