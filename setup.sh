#!/usr/bin/env bash

title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

# SANDBOX_CONF_HOME is the where we keep the common engineering configs
export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_POLYLANG_HOME=${SANDBOX_POLYLANG_HOME:-$SANDBOX_CONF_HOME/lang}
mkdir -p $SANDBOX_POLYLANG_HOME

title "Common development utilities should be installed using ./setup-privileged-common.sh already"

source ${SANDBOX_CONF_HOME}/install-secrets.sh
source ${SANDBOX_CONF_HOME}/install-pyenv.sh
source ${SANDBOX_CONF_HOME}/install-github-cli.sh
source ${SANDBOX_CONF_HOME}/install-deno.sh
source ${SANDBOX_CONF_HOME}/install-hugo.sh
source ${SANDBOX_CONF_HOME}/install-golang.sh
source ${SANDBOX_CONF_HOME}/install-lazy-docker.sh

title "Setup .zshrc and .z (for more convenience 'cd' directory changes)"
[[ -f $HOME/.zshrc ]] || ln -s $SANDBOX_CONF_HOME/zshrc $HOME/.zshrc
[[ -f $HOME/.z ]] || cp $SANDBOX_CONF_HOME/zrc .z

source ${SANDBOX_CONF_HOME}/setup-ipm.sh

title "Install SDKMAN! Java SDK Version Manager"
# we use rcupdate=false because SDKMAN! reference is already in zshrc
curl -s "https://get.sdkman.io?rcupdate=false" | bash > $SANDBOX_CONF_HOME/sdkman.log

source ${SANDBOX_CONF_HOME}/install-nodejs.sh

title "Install Rust toolchain"
curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path

source ${SANDBOX_CONF_HOME}/install-julia.sh

echo "Setup complete, logout and back in."
[[ $SHELL == '/bin/zsh' ]] || echo "IMPORTANT: A sudo user should run 'sudo usermod --shell /bin/zsh $USER' for you."
