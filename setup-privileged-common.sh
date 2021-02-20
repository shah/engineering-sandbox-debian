#!/usr/bin/env bash
# This script requires `sudo` privileges and should be run by an admin

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}

# TODO: we should try to remove as many commands from here into the unprivileged `setup.sh` as possible.
# It's not a good idea to require sandboxes to run `sudo`-based commands.

apt-get -qq update
apt-get -y -qq install wget curl git make jq bzip2 graphviz xmlstarlet zip unzip zsh zsh-antigen tree gawk iproute2
apt-get -y -qq install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libxml2-dev xz-utils tk-dev libxmlsec1-dev libreadline-dev libffi-dev libbz2-dev liblzma-dev llvm
apt-get -y -qq install --no-install-recommends zsh
apt-get -y -qq install software-properties-common lshw hwinfo
apt-get -y -qq install postgresql-client

curl -sSL https://git.io/git-extras-setup | sudo bash /dev/stdin

`dirname $0`/install-sql-privileged.sh