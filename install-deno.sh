#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}

echo "Install the latest version of Deno into $SANDBOX_CONF_HOME/bin"
curl -fsSL https://deno.land/x/install/install.sh | DENO_INSTALL=$SANDBOX_CONF_HOME sh

export SANDBOX_DENO=${SANDBOX_DENO:-$SANDBOX_CONF_HOME/bin/deno}

echo "Install 'Update Deno Dependencies' (UDD) utility"
$SANDBOX_DENO install -A -f -n udd https://deno.land/x/udd@0.4.1/main.ts

echo "Install Deno-based 'Keep a Changelog' (changelog) utility"
$SANDBOX_DENO install --allow-read --allow-write --unstable --name changelog -f https://raw.githubusercontent.com/oscarotero/keep-a-changelog/deno/bin.js
