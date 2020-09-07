#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_HAXE_HOME=${SANDBOX_HAXE_HOME:-$SANDBOX_CONF_HOME/haxe}
export SANDBOX_HAXELIB_HOME=${SANDBOX_HAXELIB_HOME:-$SANDBOX_HAXE_HOME/lib}
export SANDBOX_NEKO_HOME=${SANDBOX_NEKO_HOME:-$SANDBOX_CONF_HOME/neko}

export HAXE_REPO="HaxeFoundation/haxe"
export HAXE_VERSION=`curl -s https://api.github.com/repos/${HAXE_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`

export NEKO_REPO="HaxeFoundation/neko"
export NEKO_VERSION_HYPHEN=`curl -s https://api.github.com/repos/${NEKO_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
export NEKO_VERSION_PERIOD=`echo $NEKO_VERSION_HYPHEN | tr - .`

rm -rf $SANDBOX_HAXE_HOME
mkdir -p $SANDBOX_HAXE_HOME
curl -L https://github.com/${HAXE_REPO}/releases/download/${HAXE_VERSION}/haxe-${HAXE_VERSION}-linux64.tar.gz \
     | tar -xz --strip-components 1 -C $SANDBOX_HAXE_HOME

rm -rf $SANDBOX_NEKO_HOME
mkdir -p $SANDBOX_NEKO_HOME
curl -L https://github.com/${NEKO_REPO}/releases/download/${NEKO_VERSION_HYPHEN}/neko-${NEKO_VERSION_PERIOD:1}-linux64.tar.gz \
     | tar -xz --strip-components 1 -C $SANDBOX_NEKO_HOME

# tell haxelib where the libraries should be stored
mkdir -p $SANDBOX_HAXELIB_HOME
rm -f $HOME/.haxelib
echo $SANDBOX_HAXELIB_HOME > $HOME/.haxelib

# install default libraries
# [TypeScript declaration generator for Haxe/JS](https://lib.haxe.org/p/hxtsdgen/)
LD_LIBRARY_PATH=$SANDBOX_NEKO_HOME $SANDBOX_HAXE_HOME/haxelib install hxtsdgen
