# WSL2 Debian Engineering Sandbox Setup

Create a Debian WSL2 instance using Windows Store.

Then:

    cd $HOME
    git clone https://github.com/shah/engineering-sandbox-debian.git .engrsb
    cd .engrsb
    cp secrets.env.sample secrets.env
    vi secrets.env

Edit the .engrsb/secrets.env file, update the secret information.

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