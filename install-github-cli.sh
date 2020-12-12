#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}

export GHCLI_REPO="cli/cli"
export GHCLI_VERSION=`curl -s https://api.github.com/repos/${GHCLI_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
echo "Install GitHub CLI ($GHCLI_VERSION)"
curl -Ls https://github.com/${GHCLI_REPO}/releases/download/${GHCLI_VERSION}/gh_${GHCLI_VERSION:1}_linux_amd64.tar.gz \
     | tar -xz --strip-components 2 -C $SANDBOX_CONF_HOME/bin gh_${GHCLI_VERSION:1}_linux_amd64/bin/gh
