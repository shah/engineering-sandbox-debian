# SANDBOX_CONF_HOME is the where we keep the common engineering configs
export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export DENO_INSTALL=$SANDBOX_CONF_HOME

# Load Antigen
source /usr/share/zsh-antigen/antigen.zsh

# Load Antigen configurations
antigen init $SANDBOX_CONF_HOME/antigenrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $SANDBOX_CONF_HOME/p10k.zsh ]] || source $SANDBOX_CONF_HOME/p10k.zsh

# All downloaded binaries were put in $SANDBOX_CONF_HOME so add it to the path
export PATH=$SANDBOX_CONF_HOME/bin:$PATH