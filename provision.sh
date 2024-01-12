#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

MININET_REPO="https://github.com/mininet/mininet"
MININET_BRANCH="2.3.0"
RYU_VERSION="4.34"
MININET_IMAGE="ghcr.io/scc365/mininet:latest"
MN_IMAGE="ghcr.io/scc365/mn:latest"
PTCP_IMAGE="ghcr.io/scc365/ptcp:latest"
RYU_IMAGE="ghcr.io/scc365/ryu:latest"
ME_IMAGE="ghcr.io/scc365/me:latest"

export DEBIAN_FRONTEND=noninteractive


function install_deps() {
    apt-get update
    apt-get upgrade -yq
    apt-get install -yqq \
    software-properties-common
    add-apt-repository -y ppa:deadsnakes/ppa
    apt-get update
    apt-get upgrade -yq
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
        python3.9-dev \
        python3-pip \
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
    if ! which docker; then
        curl -fsSL https://get.docker.com | sh
        docker pull $MININET_IMAGE
        docker pull $MN_IMAGE
        docker pull $RYU_IMAGE
        docker pull $ME_IMAGE
        docker pull $PTCP_IMAGE
    fi
}

function install_mininet() {
    if ! which mn; then
        cd /root
        rm -rf ./mininet ./openflow
        git clone $MININET_REPO -b $MININET_BRANCH ./mininet
        cd mininet
        sed -i 's/git:/https:/g' ./util/install.sh
        PYTHON=python3 sh -c "./util/install.sh -fnv"
    fi
}

function install_ryu() {
    if ! which ryu-manager; then
        pip install eventlet==0.30.2
        pip install ryu==$RYU_VERSION
        curl https://raw.githubusercontent.com/scc365/ryu-base-image/main/requirements.txt -o ./requirements.txt
        pip install -r ./requirements.txt
    fi
}

function set_bashrc_message() {
    echo "echo \"||>  Advanced Networking VM  <||\"" >> "${1}"
    echo "echo \"||>  Build: $(date)\"" >> "${1}"
}

main() {
    bashrc="/etc/skel/.bashrc"
    while getopts 'r:' OPTION; do
        case "$OPTION" in
            r) 
                if [[ -f "$OPTARG" ]]; then
                    bashrc="$OPTARG"
                else
                    echo "Invalid rc file path: $OPTARG"
                    exit 1
                fi
                ;;
            ?) 
                echo "Usage: $0 [-r <rc file path>]"
                exit 0;;
        esac
    done

    install_deps
    set_bashrc_message "$bashrc"
    install_docker
    install_mininet
    install_ryu
}

main "$@"
