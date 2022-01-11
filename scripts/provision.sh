#!/usr/bin/env bash
set -e

MININET_REPO="https://github.com/mininet/mininet"
MININET_BRANCH="2.3.0"
RYU_VERSION="4.34"
MININET_IMAGE="ghcr.io/scc365/mininet:latest"
MN_IMAGE="ghcr.io/scc365/mn:latest"
PTCP_IMAGE="ghcr.io/scc365/ptcp:latest"
RYU_IMAGE="ghcr.io/scc365/ryu:latest"
ME_IMAGE="ghcr.io/scc365/me:latest"

MININET_TUTORIAL="https://github.com/scc365/mininet-tutorial"
TESTING_TUTORIAL="https://github.com/scc365/testing-tutorial"
RYU_TUTORIAL="https://github.com/scc365/ryu-tutorial"

export DEBIAN_FRONTEND=noninteractive
apt-get update

function install_deps() {
    apt-get install -yqq \
        apt-transport-https \
        ca-certificates \
        curl \
        g++ \
        gcc \
        git \
        gnupg-agent \
        hping3 \
        iperf3 \
        libffi-dev \
        libssl-dev \
        libxml2-dev \
        libxslt1-dev \
        nano \
        net-tools \
        openvswitch-common \
        python3-dev \
        python3-pip \
        software-properties-common \
        tmux \
        traceroute \
        tshark \
        vim \
        wireshark \
        x11-apps \
        xauth \
        zlib1g-dev
}

function install_docker() {
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    usermod -aG docker vagrant
}

function pull_images() {
    docker pull $MININET_IMAGE
    docker pull $MN_IMAGE
    docker pull $RYU_IMAGE
    docker pull $ME_IMAGE
    docker pull $PTCP_IMAGE
}

function install_mininet() {
    cd /root
    rm -rf ./mininet ./openflow
    git clone $MININET_REPO -b $MININET_BRANCH ./mininet
    cd mininet
    #FIX: use `https://` rather than `git://` to work with scc builds
    sed -i 's/git:/https:/g' ./util/install.sh
    PYTHON=python3 sh -c "./util/install.sh -fnv"
}

function install_ryu() {
    #FIX: recent eventlet versions will cause the install to fail
    pip install eventlet==0.30.2
    pip install ryu==$RYU_VERSION
    curl https://raw.githubusercontent.com/scc365/ryu-base-image/main/requirements.txt -o ./requirements.txt
    pip install -r ./requirements.txt
}

function install_updater() {
    chmod +x /home/vagrant/.scripts/updater
    echo "export PATH=${PATH}:/home/vagrant/.scripts/" >> /home/vagrant/.bashrc
}

function add_tutorials() {
    cd /home/vagrant
    git clone $MININET_TUTORIAL
    git clone $TESTING_TUTORIAL
    git clone $RYU_TUTORIAL
}

function set_bashrc_message() {
    touch /home/vagrant/.hushlogin
    echo "echo \"||>  Advanced Networking VM  <||\"" >> /home/vagrant/.bashrc
}

install_deps
set_bashrc_message
install_docker
pull_images
install_mininet
install_ryu
install_updater
add_tutorials
