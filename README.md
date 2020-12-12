# WSL2 Debian Engineering Sandbox Setup

Create a "disposable" Debian WSL2 instance using Windows Store. This project treats the WSL2 instance as "disposable" meaning it's for development only and can easily be destroyed and recreated whenever necessary. The cost for creation and destruction for a Engineering Sandbox should be so low that it should be treated almost as a container rather than a VM. 

## 1. Clone the Engineering Sandbox Git repo

    cd $HOME
    sudo apt-get update
    sudo apt-get install -y git vim
    git clone https://github.com/shah/engineering-sandbox-debian.git .engrsb

## 2. Understand how to manage your secrets and other confidential configurations

It's crucial that confidential config settings and secrets are never acccidentally stored in project Git repositories so it's important to manage secrets in your $HOME directory. You can then source them into projects as you need them explicitly. 

By explicitly managing secrets you will be sure that passwords and other secrets never get put into scripts and are always sourced from the environment or external "vaults".

By convention, all secrets are stored in `$HOME/.engrsb/secrets.d` as separate secrets "groups" so let's prepare the directory:

    cd $HOME/.engrsb
    ./install-secrets.sh

Edit `secrets.d/git.env` and `secrets.d/github.com.env` and add your credentials. You should segment your secrets into separate files so that they're easy to find and edit. Then, when you need them you can use this in your terminal/shell:

    source $SANDBOX_CONF_HOME/secrets.env

The default `$SANDBOX_CONF_HOME/secrets.env` just loops through each file in `$HOME/.engrsb/secrets.d` and `source`s them into the active shell. If you only need to pull in a particular secrets group you can run something like this:

    source $SANDBOX_CONF_SECRETS_HOME/git.env
    source $SANDBOX_CONF_SECRETS_HOME/github.com.env

## 3. Run the common setup

Once you've cloned the repo and setup your secrets, run the setup from your `$HOME` directory. 

    cd $HOME
    .engrsb/setup.sh

## 4. Examine what was setup:

* zsh as the default shell
* Antigen and oh-my-zsh script framework
  * [git-auto-fetch](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-auto-fetch) is turned on, see instructions to turn it off for certain repos
* `git-semver` script courtesy of [semtag](https://github.com/pnikosis/semtag)
* Powerline 10k Theme with nice defaults
* Hugo, Deno in .engrsb/bin (and in $PATH)
* Google Go in /usr/local/go
* Update Deno Dependencies (UDD) utility for `deps.ts` and module versions management
* nvm (run `nvm install node` once)
* SDKMAN! (run `sdk install java` once and then, e.g., `sdk use java 11.0.7.hs-adpt`)
* NodeJS LTS release, ESlint and Typescript as peer dependency for ESlint.
* Rust toolchain
* Julia toolchain (multiple versions supported in `$HOME/.julia/julia-X.Y.Z` with `$HOME/.julia/latest` symlink and `$HOME/.julia/latest/bin` in path)
* Python with pyenv (run `pyenv install 3.8.3` once and then, e.g. `pyenv global 3.8.3`)
* Lazy Docker in /usr/local/bin
* rupa/z directory navigation utility
* zPrezto plugin manager rcfile (for VS Code devcontainers, in case Antigen doesn't work)

# Ubuntu Notes

While this repo is mainly designed for Debian, if you're using Ubuntu you might need to do the following after calling `.engsb/setup.sh` per [this discussion](https://github.com/zsh-users/antigen/issues/659#issuecomment-413182473):

    sudo curl -o /usr/share/zsh-antigen/antigen.zsh -sL git.io/antigen

# NPM Packaging

We use GitHub NPM Package Registry. Use [these instructions](https://docs.github.com/en/packages/using-github-packages-with-your-projects-ecosystem/configuring-npm-for-use-with-github-packages).

Create `$HOME/.npmrc` with the following contents:

    //npm.pkg.github.com/:_authToken=<Personal Access Token>

Then:

    npm login --registry=https://npm.pkg.github.com
