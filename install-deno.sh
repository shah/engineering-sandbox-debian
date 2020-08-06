#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}

echo "Install the latest version of Deno into $SANDBOX_CONF_HOME/bin"
curl -fsSL https://deno.land/x/install/install.sh | DENO_INSTALL=$SANDBOX_CONF_HOME sh

echo "Install 'Update Deno Dependencies' (UDD) utility"
deno install -A -f -n udd https://deno.land/x/udd/main.ts

echo "Install Deno-based 'Keep a Changelog' (changelog) utility"
deno install --allow-read --allow-write --unstable --name changelog -f https://raw.githubusercontent.com/oscarotero/keep-a-changelog/deno/bin.js
