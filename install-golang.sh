#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_GOLANG_HOME=${SANDBOX_GOLANG_HOME:-/usr/local/go}

echo "Remove existing Google Go from $SANDBOX_GOLANG_HOME, if it exists"
sudo rm -rf $SANDBOX_GOLANG_HOME 

export SANDBOX_GO_VERSION=`curl -s https://golang.org/VERSION?m=text`
export SANDBOX_GO_PACKAGE=${SANDBOX_GO_VERSION}.linux-amd64.tar.gz

echo "Install Google Go ${SANDBOX_GO_VERSION} into $SANDBOX_GOLANG_HOME"
curl -Ls https://golang.org/dl/${SANDBOX_GO_PACKAGE} -o /tmp/${SANDBOX_GO_PACKAGE}
sudo tar -C /usr/local -xzf /tmp/${SANDBOX_GO_PACKAGE}
