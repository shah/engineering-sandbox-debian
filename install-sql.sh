#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_ENGR_BIN=${SANDBOX_ENGR_BIN:-$SANDBOX_CONF_HOME/bin}

export GLM_REPO="golang-migrate/migrate"
export GLM_VERSION=`curl -s https://api.github.com/repos/${GLM_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -Ls https://github.com/${GLM_REPO}/releases/download/${GLM_VERSION}/migrate.linux-amd64.tar.gz | tar -xz -C $SANDBOX_ENGR_BIN --no-anchored migrate.linux-amd64
mv $SANDBOX_ENGR_BIN/migrate.linux-amd64 $SANDBOX_ENGR_BIN/migrate
