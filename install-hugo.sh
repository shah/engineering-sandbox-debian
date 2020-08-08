#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}

export HUGO_REPO="gohugoio/hugo"
export HUGO_VERSION=`curl -s https://api.github.com/repos/${HUGO_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
echo "Install the latest version ($HUGO_VERSION) of hugo and hugox (extended)"
curl -L https://github.com/${HUGO_REPO}/releases/download/${HUGO_VERSION}/hugo_extended_${HUGO_VERSION:1}_Linux-64bit.tar.gz \
     | tar -xz -C $SANDBOX_CONF_HOME/bin hugo
mv $SANDBOX_CONF_HOME/bin/hugo $SANDBOX_CONF_HOME/bin/hugox
curl -L https://github.com/${HUGO_REPO}/releases/download/${HUGO_VERSION}/hugo_${HUGO_VERSION:1}_Linux-64bit.tar.gz \
     | tar -xz -C $SANDBOX_CONF_HOME/bin hugo
