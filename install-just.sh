#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}

# https://github.com/casey/just
echo "Install the latest version of Just command runner into $SANDBOX_CONF_HOME/bin"
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to $SANDBOX_CONF_HOME/bin
