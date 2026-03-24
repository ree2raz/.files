# Minimal Sandbox For Harnesses

A hardened, isolated Docker sandbox running inside WSL2 — agents get internet, their own persistent filesystem, and full dev tooling, but have zero visibility into your Windows or WSL2 machine.

## One Setup

```bash
# 1. Network
docker network create --driver bridge \
  --opt com.docker.network.driver.mtu=1350 agent-net

# 2. Volumes
docker volume create agent-home
docker volume create agent-data

# 3. WSL2 host kernel params
echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
echo "fs.inotify.max_user_instances=512" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# 4. Build image
docker build -t agent-base:latest ~/agent-sandbox/

mkdir ~/agent-sandbox/workspace
mkdir ~/agent-sandbox/logs
```

## Daily Workflow

```bash
# Start sandbox
~/agent-sandbox/run-agent.sh

# Inside container — install any agent
cd /workspace
# hermes-agent, opencode, whatever — install and run here

# Exchange files with your WSL2/Windows machine
# Write outputs to /workspace → appears at ~/agent-sandbox/workspace in WSL2
# Access from Windows at \\wsl$\Ubuntu\home\rituraj\agent-sandbox\workspace

# Exit — container destroyed, but:
# /home/agentuser persists on agent-home volume (installed tools, configs)
# /opt/agent persists on agent-data volume (agent state, cache, DBs)
# /workspace persists on WSL2 bind mount (your file exchange)
```

## Isolation Boundaries

```bash
Windows Machine
└── WSL2 Ubuntu
    ├── ~/agent-sandbox/workspace  ← only shared surface
    ├── ~/agent-sandbox/logs       ← only shared surface
    └── Docker Container (agent-dev)
        ├── Internet ✅ (TCP/HTTPS only)
        ├── /workspace ✅ (bind mounted)
        ├── /home/agentuser ✅ (named volume, persistent)
        ├── /opt/agent ✅ (named volume, persistent)
        ├── Your WSL2 home ❌ invisible
        ├── Windows C:\ ❌ invisible
        ├── Raw sockets ❌ blocked
        └── Kernel/host privileges ❌ blocked
```

## If the image needs rebuilding

```bash
# Rebuild without losing volume data
docker build -t agent-base:latest ~/agent-sandbox/

# Volumes are independent of the image — agent-home and agent-data survive rebuilds
```
