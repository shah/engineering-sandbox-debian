#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_ENGR_BIN=${SANDBOX_ENGR_BIN:-$SANDBOX_CONF_HOME/bin}

# [fsql](https://github.com/kashav/fsql) searches through your filesystem with SQL-esque queries
export FSQL_REPO="kashav/fsql"
export FSQL_VERSION=`curl -s https://api.github.com/repos/${FSQL_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -Ls https://github.com/${FSQL_REPO}/releases/download/${FSQL_VERSION}/fsql-${FSQL_VERSION:1}-linux-amd64.tar.gz |\
     tar -xz -C $SANDBOX_ENGR_BIN --strip-components=1 linux-amd64/fsql
