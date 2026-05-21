FROM debian:13-slim

ENV DEBIAN_FRONTEND=noninteractive \
    WINEDEBUG=-all \
    WINEPREFIX=/wine \
    DISPLAY=:99

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates curl xvfb \
    && mkdir -pm755 /etc/apt/keyrings \
    && curl -sL https://dl.winehq.org/wine-builds/winehq.key -o /etc/apt/keyrings/winehq-archive.key \
    && curl -sL https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources -o /etc/apt/sources.list.d/winehq.sources \
    && apt-get update \
    && apt-get install -y --no-install-recommends winehq-staging \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN wineboot --init

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7707/udp
EXPOSE 7708/udp
EXPOSE 7717/udp
EXPOSE 20560/udp
EXPOSE 28852/tcp
EXPOSE 28852/udp
EXPOSE 8075/tcp

ENTRYPOINT ["/entrypoint.sh"]