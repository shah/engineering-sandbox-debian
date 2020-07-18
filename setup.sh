#!/usr/bin/env bash

title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

# SANDBOX_CONF_HOME is the where we keep the common engineering configs
export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_CONF_PARAMS_FILE=${SANDBOX_CONF_PARAMS_FILE:-$SANDBOX_CONF_HOME/secrets.env}

[[ -f $SANDBOX_CONF_PARAMS_FILE ]] || { echo >&2 "$SANDBOX_CONF_PARAMS_FILE not found, need SANDBOX_GIT_* variables."; exit 1; }
source $SANDBOX_CONF_PARAMS_FILE

[[ $SANDBOX_GIT_USER_EMAIL ]] || { echo >&2 "SANDBOX_GIT_USER_EMAIL variable not set"; exit 1; }
[[ $SANDBOX_GIT_USER_NAME ]] || { echo >&2 "SANDBOX_GIT_USER_NAME variable not set"; exit 1; }

title "Update package references"
sudo apt-get update

title "Install common development utilities"
sudo apt-get install -y wget curl git make jq bzip2 graphviz xmlstarlet zip unzip zsh zsh-antigen tree gawk iproute2
sudo apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev

title "Install the latest version of Deno into $SANDBOX_CONF_HOME/bin"
curl -fsSL https://deno.land/x/install/install.sh | DENO_INSTALL=$SANDBOX_CONF_HOME sh
title "Install Update Deno Dependencies (UDD) utility"
deno install --root $SANDBOX_CONF_HOME -A -f -n udd https://deno.land/x/udd/main.ts

export HUGO_REPO="gohugoio/hugo"
export HUGO_VERSION=`curl -s https://api.github.com/repos/${HUGO_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
title "Install the latest version ($HUGO_VERSION) of hugo and hugox (extended)"
curl -L https://github.com/${HUGO_REPO}/releases/download/${HUGO_VERSION}/hugo_extended_${HUGO_VERSION:1}_Linux-64bit.tar.gz \
     | tar -xz -C $SANDBOX_CONF_HOME/bin hugo
mv $SANDBOX_CONF_HOME/bin/hugo $SANDBOX_CONF_HOME/bin/hugox
curl -L https://github.com/${HUGO_REPO}/releases/download/${HUGO_VERSION}/hugo_${HUGO_VERSION:1}_Linux-64bit.tar.gz \
     | tar -xz -C $SANDBOX_CONF_HOME/bin hugo

title "Setup .zshrc and .z (for more convenience 'cd' directory changes)"
[[ -f $HOME/.zshrc ]] || ln -s $SANDBOX_CONF_HOME/zshrc $HOME/.zshrc
[[ -f $HOME/.z ]] || cp $SANDBOX_CONF_HOME/zrc .z

title "Switch $USER default shell to ZSH"
[[ $SHELL == '/bin/zsh' ]] || sudo usermod --shell /bin/zsh $USER

title "Set global git configs for $SANDBOX_GIT_USER_NAME ($SANDBOX_GIT_USER_EMAIL)"
git config --global user.email "$SANDBOX_GIT_USER_EMAIL"
git config --global user.name "$SANDBOX_GIT_USER_NAME"
git config --global push.default simple
git config --global pull.rebase false 
git config --global push.followTags true

title "Set 30 day timeout for Git credentials cache"
git config --global credential.helper 'cache --timeout=2592000'

title "Get latest version of Semantic Version tagging script"
curl -L "https://raw.githubusercontent.com/pnikosis/semtag/master/semtag" > $SANDBOX_CONF_HOME/bin/git-semtag
chmod +x $SANDBOX_CONF_HOME/bin/git-semtag

title "Install SDKMAN! Java SDK Version Manager"
# we use rcupdate=false because SDKMAN! reference is already in zshrc
curl -s "https://get.sdkman.io?rcupdate=false" | bash > $SANDBOX_CONF_HOME/sdkman.log

title "Install Rust toolchain"
curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path

echo "Setup complete, logout and back in."
