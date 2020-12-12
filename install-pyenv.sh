#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_POLYLANG_HOME=${SANDBOX_POLYLANG_HOME:-$SANDBOX_CONF_HOME/lang}
export PYENV_ROOT="$SANDBOX_POLYLANG_HOME/pyenv"
export PYENV_PLUGINS_HOME=$PYENV_ROOT/plugins

[ -d $PYENV_ROOT ] || git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
(cd $PYENV_ROOT; git pull)

PYENVPLUGIN_INSTALL_LATEST=$PYENV_PLUGINS_HOME/pyenv-install-latest
PYENVPLUGIN_VIRTUALENV=$PYENV_PLUGINS_HOME/pyenv-virtualenv

[ -d $PYENVPLUGIN_INSTALL_LATEST ] || git clone https://github.com/momo-lab/pyenv-install-latest.git $PYENVPLUGIN_INSTALL_LATEST
(cd $PYENVPLUGIN_INSTALL_LATEST; git pull)

[ -d $PYENVPLUGIN_VIRTUALENV ] || git clone https://github.com/yyuu/pyenv-virtualenv.git $PYENVPLUGIN_VIRTUALENV
(cd $PYENVPLUGIN_VIRTUALENV; git pull)
