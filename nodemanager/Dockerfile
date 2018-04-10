FROM hadoop-azure-base:latest
COPY etc /etc
COPY start.sh /
EXPOSE 45454 8042 10200 8188 8190
ENTRYPOINT bash /start.sh && tail -F /usr/local/hadoop/logs/*