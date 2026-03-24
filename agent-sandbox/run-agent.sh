#!/bin/bash
WORKSPACE="$HOME/agent-sandbox/workspace"
LOGS="$HOME/agent-sandbox/logs"

docker run -it --rm \
  --name agent \
  --network agent-net \
  --hostname agent-dev \
  \
  --cap-drop ALL \
  --cap-add NET_BIND_SERVICE \
  --cap-add CHOWN \
  --cap-add SETUID \
  --cap-add SETGID \
  --cap-add AUDIT_WRITE \
  --cap-add DAC_OVERRIDE \
  --cap-add FOWNER \
  --cap-add SYS_PTRACE \
  \
  --ulimit nofile=65536:65536 \
  --memory 3g \
  --cpus 2 \
  --shm-size 512m \
  \
  -e TZ=Asia/Kolkata \
  -e TERM=xterm-256color \
  -e LANG=en_US.UTF-8 \
  \
  -v agent-home:/home/agentuser \
  -v agent-data:/opt/agent \
  -v "$WORKSPACE":/workspace \
  -v "$LOGS":/logs \
  agent-base:latest bash
