sudo add-apt-repository ppa:wslutilities/wslu

sudo apt update && sudo apt upgrade -y

sudo apt install -y software-properties-common ca-certificates apt-transport-https gnupg lsb-release

## WSLU ##
sudo apt install wslu -y

sudo apt install -y \
  build-essential pkg-config cmake ninja-build \
  gdb valgrind lldb \
  clang clang-format clang-tidy \
  autoconf automake libtool

sudo apt install -y \
  git git-lfs tig \
  curl wget rsync openssh-client \
  unzip zip p7zip-full tar \
  htop sysstat iotop lsof strace \
  ripgrep fd-find fzf \
  tree ncdu \
  jq yq \
  tmux screen \
  vim \
  silversearcher-ag \
  net-tools inetutils-ping dnsutils iproute2 \
  whois traceroute nmap \
  bat eza bubblewrap

sudo apt install -y ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
sudo snap install yazi --classic
sudo snap install zellij --classic
sudo apt install -y \
  python3 python3-pip python3-venv \
  default-jdk maven gradle \
  ruby-full \
  php-cli php-mbstring php-xml php-curl \
  perl

## WEB / HTTP TOOLING
sudo apt install -y \
  httpie \
  openssl \
  socat netcat-openbsd \
  iptables iputils-tracepath \
  apache2-utils

## DOCKER ##
sudo usermod -aG docker "$USER"

## AWS ##
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
unzip /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install

## GCP CLI ##
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli

## GH CLI ##
sudo apt-get install gh

## This improves copy/paste and monospace fonts. ##
sudo apt install -y \
  xsel xclip \
  fonts-firacode

## Nice to have utilities ##
sudo apt install -y \
  ncurses-term \
  asciinema \
  shellcheck \
  graphviz \
  imagemagick \
  lnav \
  colordiff

## GUI ##
sudo apt install -y x11-apps mesa-utils libgl1-mesa-dri
sudo apt install -y x11-apps firefox snapd
sudo apt install -y ibus # Keyboard Shortcuts
sudo apt install -y task-xfce-desktop xfce4-terminal

# Graphics stack (Essential for WSLg)
sudo apt install -y libwayland-dev libxkbcommon-dev libinput-dev libseat-dev libdisplay-info-dev libliftoff-dev libinput-dev libxcb-xinput-dev libxcb-keysyms1-dev libxcb-icccm4-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-xfixes0-dev libxcb-image0-dev libxcb-randr0-dev libxcb-shape0-dev libxcb-xinerama0-dev libxcb-sync-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libxkbregistry-dev libegl-dev libgles2-mesa-dev libdrm-dev libgbm-dev libvulkan-dev

# System fonts (UI development)
sudo apt install -y fontconfig fonts-dejavu-core fonts-noto fonts-noto-color-emoji

# Audio (If your desktop needs sound)
sudo apt install -y libasound2-dev libpulse-dev pipewire pipewire-pulse

# GUI Debugging
sudo apt install -y xdotool wmctrl
sudo apt install -y wireshark

sudo apt install -y linux-tools-common linux-tools-generic

wget https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage && ./nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

# Fix for GPG signing in WSL2 (if you use git commit signing)
export GPG_TTY=$(tty)
##

## NVM ##
# Install NVM
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
# reload shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

nvm install --lts
nvm alias default 'lts/*'

## UV ##
curl -LsSf https://astral.sh/uv/install.sh | sh

## RUST ##
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

## ~/.bashrc
alias lh='ls -halt'
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --git --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias tree='eza --tree --icons'

alias bat='bat --paging=never'
# Clipboard integration (Fixes copy-paste issues)
alias clip='clip.exe'
alias explorer='wslview .'
alias open='wslview'
alias ipconfig='ipconfig.exe'

source ~/.bashrc

echo 'eval "$(uv generate-shell-completion bash)"' >>~/.bashrc
uv python install 3.11 3.12 3.13 3.14
uv python install 3.12 --default

rustup default stable
rustup component add rustfmt clippy
# Cargo extras for GUI dev
cargo install cargo-watch cargo-run-bin
# Performance Profiling
cargo install flamegraph

# git config --global gpg.format ssh
# git config --global user.signingkey ~/.ssh/id_ed25519.pub
# git config --global commit.gpgsign true
