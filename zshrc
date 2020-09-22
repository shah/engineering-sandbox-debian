# SANDBOX_CONF_HOME is the where we keep the common engineering configs
export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_WORKSP_HOME=${SANDBOX_WORKSP_HOME:-$HOME/workspaces}

# Visual Studio Code Team utilities for managing code repos
export VSCODE_TEAM_VERSION=`curl -s https://api.github.com/repos/shah/vscode-team/tags  | jq '.[0].name' -r`
alias projectctl="deno run -A --unstable 'https://denopkg.com/shah/vscode-team@${VSCODE_TEAM_VERSION}/projectctl.ts'"
alias wsctl="deno run -A --unstable 'https://denopkg.com/shah/vscode-team@${VSCODE_TEAM_VERSION}/wsctl.ts'"

# Same as above except reloads from source location
alias projectctlr="deno run -A --unstable --reload 'https://denopkg.com/shah/vscode-team@${VSCODE_TEAM_VERSION}/projectctl.ts'"
alias wsctlr="deno run -A --unstable --reload 'https://denopkg.com/shah/vscode-team@${VSCODE_TEAM_VERSION}/wsctl.ts'"

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

# Julia toolchain
export JULIA_HOME=${JULIA_HOME:-$HOME/.julia}
path+=($JULIA_HOME/latest/bin)

# Engineering Sandbox frequently used commands
alias engrsb-upgrade="cd $SANDBOX_CONF_HOME; git pull && cd $HOME; .engrsb/setup.sh --upgrade"

# Deno aliases for frequently used commands
export DENO_INSTALL=$SANDBOX_CONF_HOME
export DENO_CACHES_HOME=$HOME/.cache/deno
path+=($DENO_INSTALL/bin)
path+=($HOME/.deno/bin)
alias deno-install="deno install"
alias deno-run="deno run -A --unstable"
alias deno-lint="deno lint --unstable"
alias deno-test="deno fmt ; deno test -A --unstable --coverage"
alias deno-clear-caches="rm -rf $DENO_CACHES_HOME/deps; rm -rf $DENO_CACHES_HOME/gen"
alias deno-deps-check="udd *.ts --dry-run"
alias deno-udd-all="udd *.ts"
alias deno-udd="udd deps.ts"

# Haxe and Neko setup
export HAXE_HOME=$HOME/.engrsb/haxe
export HAXELIB_HOME=$HOME/.engrsb/.haxelib
export NEKO_HOME=$HOME/.engrsb/neko
alias haxe="$HAXE_HOME/haxe"
alias haxelib="LD_LIBRARY_PATH=$NEKO_HOME $HAXE_HOME/haxelib"

# Use SDKMAN! for Java SDK version managment
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
