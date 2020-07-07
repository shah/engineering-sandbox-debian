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
  * [git-auto-fetch](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-auto-fetch) is turned on, see instructions to turn it off for certain repos
* Powerline 10k Theme with nice defaults
* Hugo, Deno in .engrsb/bin (and in $PATH)
* nvm (run `nvm install node` once)
* SDKMAN! (run `sdk install java` once and then, e.g., `sdk use java 11.0.7.hs-adpt`)
* Rust toolchain
* Python with pyenv (run `pyenv install 3.8.3` once and then, e.g. `pyenv global 3.8.3`)

sudo curl -o /usr/share/zsh-antigen/antigen.zsh -sL git.io/antigen

Setup projects folder structure:

    mkdir -p $HOME/workspaces/git.netspective.io
    mkdir -p $HOME/workspaces/github.com

If you use any other repos, create appropriate subdirectories above.

# Ubuntu Notes

While this repo is mainly designed for Debian, if you're using Ubuntu you might need to do the following after calling `.engsb/setup.sh` per [this discussion](https://github.com/zsh-users/antigen/issues/659#issuecomment-413182473):

    sudo curl -o /usr/share/zsh-antigen/antigen.zsh -sL git.io/antigen

