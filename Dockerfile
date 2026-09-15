FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    unzip \
    ca-certificates \
    libstdc++6 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1001 terraria && \
    useradd -u 1001 -g terraria -m terraria

ENV HOME=/home/terraria

RUN mkdir -p /home/terraria/.local/share/Terraria/Worlds/ && chown -R terraria:terraria /home/terraria

WORKDIR /home/terraria

USER terraria

RUN wget -O server.zip https://terraria.org/api/download/pc-dedicated-server/terraria-server-1458.zip \
    && unzip server.zip \
    && rm server.zip

WORKDIR /home/terraria/1458/Linux
RUN chmod +x TerrariaServer.bin.x86_64

EXPOSE 7777

CMD ["/home/terraria/1458/Linux/TerrariaServer.bin.x86_64", "-config", "/home/terraria/serverconfig.txt"]
