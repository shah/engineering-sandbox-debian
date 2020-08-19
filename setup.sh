#!/usr/bin/env bash

title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

# SANDBOX_CONF_HOME is the where we keep the common engineering configs
export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}

title "Update package references"
sudo apt-get update

title "Install common development utilities"
sudo apt-get install -y wget curl git make jq bzip2 graphviz xmlstarlet zip unzip zsh zsh-antigen tree gawk iproute2 vim
sudo apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libxml2-dev xz-utils tk-dev libxmlsec1-dev libreadline-dev libffi-dev libbz2-dev liblzma-dev llvm
source ${SANDBOX_CONF_HOME}/install-deno.sh
source ${SANDBOX_CONF_HOME}/install-hugo.sh

title "Setup Lazy Docker utility for local container observability"
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | sudo bash

title "Setup .zshrc and .z (for more convenience 'cd' directory changes)"
[[ -f $HOME/.zshrc ]] || ln -s $SANDBOX_CONF_HOME/zshrc $HOME/.zshrc
[[ -f $HOME/.z ]] || cp $SANDBOX_CONF_HOME/zrc .z

title "Switch $USER default shell to ZSH"
[[ $SHELL == '/bin/zsh' ]] || sudo usermod --shell /bin/zsh $USER

source ${SANDBOX_CONF_HOME}/setup-ipm.sh

title "Install SDKMAN! Java SDK Version Manager"
# we use rcupdate=false because SDKMAN! reference is already in zshrc
curl -s "https://get.sdkman.io?rcupdate=false" | bash > $SANDBOX_CONF_HOME/sdkman.log

title "Install Rust toolchain"
curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path

source ${SANDBOX_CONF_HOME}/install-julia.sh

echo "Setup complete, logout and back in."
