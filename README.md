# WSL2 Debian Engineering Sandbox Setup

Create a "disposable" Debian WSL2 instance using Windows Store. This project treats the WSL2 instance as "disposable" meaning it's for development only and can easily be destroyed and recreated whenever necessary. The cost for creation and destruction for a Engineering Sandbox should be so low that it should be treated almost as a container rather than a VM. 

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
* `git-semver` script courtesy of [semtag](https://github.com/pnikosis/semtag)
* Powerline 10k Theme with nice defaults
* Hugo, Deno in .engrsb/bin (and in $PATH)
* Update Deno Dependencies (UDD) utility for `deps.ts` and module versions management
* nvm (run `nvm install node` once)
* SDKMAN! (run `sdk install java` once and then, e.g., `sdk use java 11.0.7.hs-adpt`)
* Rust toolchain
* Julia toolchain (multiple versions supported in `$HOME/.julia/julia-X.Y.Z` with `$HOME/.julia/latest` symlink and `$HOME/.julia/latest/bin` in path)
* Python with pyenv (run `pyenv install 3.8.3` once and then, e.g. `pyenv global 3.8.3`)
* Lazy Docker in /usr/local/bin
* rupa/z directory navigation utility
* zPrezto plugin manager rcfile (for VS Code devcontainers, in case Antigen doesn't work)

# Project Directories

Setup projects folder structure:

    mkdir -p $HOME/workspaces/git.netspective.io
    mkdir -p $HOME/workspaces/github.com

If you use any other repos, create appropriate subdirectories above.

# Ubuntu Notes

While this repo is mainly designed for Debian, if you're using Ubuntu you might need to do the following after calling `.engsb/setup.sh` per [this discussion](https://github.com/zsh-users/antigen/issues/659#issuecomment-413182473):

    sudo curl -o /usr/share/zsh-antigen/antigen.zsh -sL git.io/antigen

# NPM Packaging

We use GitHub NPM Package Registry. Use [these instructions](https://docs.github.com/en/packages/using-github-packages-with-your-projects-ecosystem/configuring-npm-for-use-with-github-packages).

Create `$HOME/.npmrc` with the following contents:

    //npm.pkg.github.com/:_authToken=<Personal Access Token>

Then:

    npm login --registry=https://npm.pkg.github.com
