#!/usr/bin/env bash
#
# Engineering sandbox CLI shell setup script.
# Can be run using `curl ... | bash` or `source setup-deb-zsh-zprezto.sh` as part of
# `setup.sh` in this repo.
#
echo "Install ZSH and related shell/CLI developer requirements"
sudo apt-get -qq update && sudo apt-get -y -qq install --no-install-recommends zsh git curl wget

echo "Install prezto ZSH module framework and symlink prezto-suggested ZSH rcfiles"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
rm -f $HOME/.zshrc
/bin/zsh -c 'setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'

echo "Switch $USER default shell to ZSH"
[[ $SHELL == '/bin/zsh' ]] || sudo usermod --shell /bin/zsh $USER

# If running using `curl ... | bash`, after execution of this script, get the standard associated ZSH
# rcfiles (for Powerline10k theme and related defaults) using the following commands. If running as part
# of `setup.sh` the files will already be installed properly.
#
# curl https://raw.githubusercontent.com/shah/engineering-sandbox-debian/master/p10k.zsh > $HOME/.p10k.zsh
# curl https://raw.githubusercontent.com/shah/engineering-sandbox-debian/master/zpreztorc > $HOME/.zprezto/runcoms/zpreztorc
