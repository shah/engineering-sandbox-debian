#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_DOLT_PARAMS_ENVFILE=${SANDBOX_DOLT_PARAMS_ENVFILE:-$SANDBOX_CONF_HOME/secrets.env}

[[ -f $SANDBOX_DOLT_PARAMS_ENVFILE ]] || { echo >&2 "$SANDBOX_DOLT_PARAMS_ENVFILE not found, need SANDBOX_DOLT_* variables."; exit 1; }
source $SANDBOX_DOLT_PARAMS_ENVFILE

[[ $SANDBOX_DOLT_USER_EMAIL ]] || { echo >&2 "SANDBOX_DOLT_USER_EMAIL variable not set"; exit 1; }
[[ $SANDBOX_DOLT_USER_NAME ]] || { echo >&2 "SANDBOX_DOLT_USER_NAME variable not set"; exit 1; }

export DOLT_BIN_HOME=${DOLT_BIN_HOME:-$SANDBOX_CONF_HOME/bin}
export DOLT_REPO="liquidata-inc/dolt"
export DOLT_VERSION=`curl -s https://api.github.com/repos/${DOLT_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
echo "Install Dolt $DOLT_VERSION in $DOLT_BIN_HOME"
curl -Ls https://github.com/${DOLT_REPO}/releases/download/${DOLT_VERSION}/dolt-linux-amd64.tar.gz \
     | tar -xz -C $DOLT_BIN_HOME dolt-linux-amd64/bin/
mv $DOLT_BIN_HOME/dolt-linux-amd64/bin/* $DOLT_BIN_HOME
rm -rf $DOLT_BIN_HOME/dolt-linux-amd64/bin

$DOLT_BIN_HOME/dolt config --global --add user.email "$SANDBOX_DOLT_USER_EMAIL"
$DOLT_BIN_HOME/dolt config --global --add user.name "$SANDBOX_DOLT_USER_NAME"
$DOLT_BIN_HOME/dolt config --global --list