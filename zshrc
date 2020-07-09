# SANDBOX_CONF_HOME is the where we keep the common engineering configs
export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}

# Load Antigen
source /usr/share/zsh-antigen/antigen.zsh

# Load Antigen configurations
antigen init $SANDBOX_CONF_HOME/antigenrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $SANDBOX_CONF_HOME/p10k.zsh ]] || source $SANDBOX_CONF_HOME/p10k.zsh

# All downloaded binaries were put in $SANDBOX_CONF_HOME so add it to the path
path+=($SANDBOX_CONF_HOME/bin)

# Rust toolchain
path+=($HOME/.cargo/bin)
source $HOME/.cargo/env

# Engineering Sandbox frequently used commands
alias engrsb-upgrade="cd $HOME; .engrsb/setup.sh --upgrade"

# Deno aliases for frequently used commands
export DENO_INSTALL=$SANDBOX_CONF_HOME
export DENO_CACHES_HOME=$HOME/.cache/deno
alias deno-run="deno run -A --unstable"
alias deno-test="deno fmt ; deno test -A --unstable"
alias deno-clear-caches="rm -rf $DENO_CACHES_HOME/deps; rm -rf $DENO_CACHES_HOME/gen"

# Use SDKMAN! for Java SDK version managment
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
