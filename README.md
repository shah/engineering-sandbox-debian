# WSL2 Debian Engineering Sandbox Setup

Create a Debian WSL2 instance using Windows Store.

Then:

    cd $HOME
    sudo apt-get update
    sudo apt-get install -y git
    git clone https://github.com/shah/engineering-sandbox-debian.git .engrsb
    cd .engrsb
    cp secrets.env.sample secrets.env
    vi secrets.env

Edit `.engrsb/secrets.env` with your secret information.

Then:

    cd $HOME
    .engrsb/setup.sh

Now the following will be setup:

* zsh as the default shell
* Antigen and oh-my-zsh script framework
* Powerline 10k Theme with nice defaults
* Hugo, Deno in .engrsb/bin (and in $PATH)
* TODO: Java with SDKMAN!
* TODO: Rust
* TODO: Python with pyenv

Setup projects folder structure:

    mkdir -p $HOME/workspaces/git.netspective.io
    mkdir -p $HOME/workspaces/github.com

If you use any other repos, create appropriate subdirectories above.
