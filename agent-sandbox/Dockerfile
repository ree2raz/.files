FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo curl wget git unzip \
    ripgrep build-essential make \
    ca-certificates gnupg \
    jq iputils-ping dnsutils netcat-openbsd \
    apt-transport-https software-properties-common \
    procps lsof htop tree iproute2 \
    vim nano \
    tar gzip bzip2 xz-utils \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN userdel -r ubuntu 2>/dev/null || true && \
    useradd -m -s /bin/bash -u 1000 agentuser && \
    mkdir -p /workspace /logs /opt/agent && \
    chown agentuser:agentuser /workspace /logs /opt/agent

RUN echo 'Cmnd_Alias APT = /usr/bin/apt, /usr/bin/apt-get' > /etc/sudoers.d/agentuser-apt && \
    echo 'agentuser ALL=(ALL) NOPASSWD: APT' >> /etc/sudoers.d/agentuser-apt && \
    chmod 440 /etc/sudoers.d/agentuser-apt

USER agentuser
ENV PATH="/home/agentuser/.local/bin:$PATH"
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

WORKDIR /workspace
