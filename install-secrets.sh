#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_CONF_SECRETS_HOME=${SANDBOX_CONF_SECRETS_HOME:-$SANDBOX_CONF_HOME/secrets.d}

if [[ ! -e $SANDBOX_CONF_SECRETS_HOME ]]; then
    mkdir -p $SANDBOX_CONF_SECRETS_HOME
    echo 'export SANDBOX_GIT_USER_EMAIL="developer@netspective.com"' > $SANDBOX_CONF_SECRETS_HOME/git.env
    echo 'export SANDBOX_GIT_USER_NAME="Developer Full Name"' >> $SANDBOX_CONF_SECRETS_HOME/git.env
    echo 'export SANDBOX_GITHUB_PAT="<YOUR GITHUB ACCESS TOKEN>"' > $SANDBOX_CONF_SECRETS_HOME/github.com.env
    echo "Created $SANDBOX_CONF_SECRETS_HOME"
elif [[ ! -d $SANDBOX_CONF_SECRETS_HOME ]]; then
    echo "$SANDBOX_CONF_SECRETS_HOME should be a directory" 1>&2
else 
    echo "$SANDBOX_CONF_SECRETS_HOME aready exists (no changes made)" 1>&2
fi
