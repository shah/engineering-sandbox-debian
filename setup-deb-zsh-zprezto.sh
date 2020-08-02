#!/usr/bin/env bash

log() { 
    printf "\n\033[1;37m$1\033[0m\n" 
}

log "Install ZSH and related shell/CLI developer requirements"
sudo apt-get -qq update && sudo apt-get -y -qq install --no-install-recommends zsh git curl wget

log "Install prezto ZSH module framework and symlink prezto-suggested ZSH rcfiles"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
rm -f $HOME/.zshrc
/bin/zsh -c 'setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'

log "Switch $USER default shell to ZSH"
[[ $SHELL == '/bin/zsh' ]] || sudo usermod --shell /bin/zsh $USER

# After using this script, get the standard associated ZSH rcfiles
# curl https://raw.githubusercontent.com/shah/engineering-sandbox-debian/master/p10k.zsh > $HOME/.p10k.zsh
# curl https://raw.githubusercontent.com/shah/engineering-sandbox-debian/master/zpreztorc > $HOME/.zprezto/runcoms/zpreztorc
