FROM python:3.7-slim

ENV DEVPI_SERVERDIR=/mnt/server \
    DEVPI_CLIENTDIR=/mnt/client \
    DEVPI_MIRROR_CACHE_EXPIRY=86400

COPY ["requirements.txt", "logger_cfg.json", "run.sh", "/"]

RUN pip install --no-cache-dir -r /requirements.txt && \
    rm /requirements.txt && \
    chmod 0555 /run.sh /logger_cfg.json


VOLUME /mnt
EXPOSE 3141
USER 997

CMD "/run.sh"
