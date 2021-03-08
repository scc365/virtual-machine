#!/usr/bin/env bash

mininet_repository="https://github.com/advanced-networking/mininet"
mininet_image="ghcr.io/advanced-networking/mininet:latest"
ryu_repository="https://github.com/advanced-networking/ryu"
ryu_image="ghcr.io/advanced-networking/ryu:latest"


export DEBIAN_FRONTEND=noninteractive
apt-get update

function install_deps() {
    apt-get install -yqq \
        apt-transport-https \
        ca-certificates \
        curl \
        gcc \
        git \
        gnupg-agent \
        hping3 \
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
}

function pull_images() {
    docker pull $mininet_image
    docker pull $ryu_image
}

function install_mininet() {
    cd /root
    git clone $mininet_repository -b lancs mininet
    cd mininet
    sh -c "/root/mininet/util/install.sh -fnv"
}

function install_ryu() {
    cd /root
    git clone $ryu_repository -b lancs ryu
    cd ryu
    pip3 install .
}

install_deps
install_docker
pull_images
install_mininet
install_ryu