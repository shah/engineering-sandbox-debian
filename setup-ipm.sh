#!/usr/bin/env bash
#
# Engineering sandbox intellectual property (source code) management (IPM) setup script.
# Uses `secrets.env` to obtain Git user email and name defaults and then configures
# standard Git parameters based on typical defaults.
#
# Also installs:
# * `github.com/profclems/glab` GitLab CLI utility
#
export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_GIT_PARAMS_ENVFILE=${SANDBOX_GIT_PARAMS_ENVFILE:-$SANDBOX_CONF_HOME/secrets.d/git.env}

[[ -f $SANDBOX_GIT_PARAMS_ENVFILE ]] || { echo >&2 "$SANDBOX_GIT_PARAMS_ENVFILE not found, need SANDBOX_GIT_* variables."; exit 1; }
source $SANDBOX_GIT_PARAMS_ENVFILE

[[ $SANDBOX_GIT_USER_EMAIL ]] || { echo >&2 "SANDBOX_GIT_USER_EMAIL variable not set"; exit 1; }
[[ $SANDBOX_GIT_USER_NAME ]] || { echo >&2 "SANDBOX_GIT_USER_NAME variable not set"; exit 1; }

echo "Set global git configs for $SANDBOX_GIT_USER_NAME ($SANDBOX_GIT_USER_EMAIL)"
git config --global user.email "$SANDBOX_GIT_USER_EMAIL"
git config --global user.name "$SANDBOX_GIT_USER_NAME"
git config --global push.default simple
git config --global pull.rebase false 
git config --global push.followTags true

# Set 30 day timeout for Git credentials cache
git config --global credential.helper 'cache --timeout=2592000'

echo "Get latest version of Semantic Version tagging script"
curl -Ls "https://raw.githubusercontent.com/pnikosis/semtag/master/semtag" > $SANDBOX_CONF_HOME/bin/git-semtag
chmod +x $SANDBOX_CONF_HOME/bin/git-semtag

export GLAB_REPO="profclems/glab"
export GLAB_VERSION=`curl -s https://api.github.com/repos/${GLAB_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -Ls https://github.com/${GLAB_REPO}/releases/download/${GLAB_VERSION}/glab_${GLAB_VERSION:1}_Linux_x86_64.tar.gz \
     | tar -xz -C $SANDBOX_CONF_HOME/bin glab
