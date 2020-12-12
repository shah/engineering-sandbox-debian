title "Setup Lazy Docker utility for local container observability"

# built from https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh
# prepare the download URL
ARCH=x86
GITHUB_LATEST_VERSION=$(curl -L -s -H 'Accept: application/json' https://github.com/jesseduffield/lazydocker/releases/latest | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
GITHUB_FILE="lazydocker_${GITHUB_LATEST_VERSION//v/}_$(uname -s)_${ARCH}.tar.gz"
GITHUB_URL="https://github.com/jesseduffield/lazydocker/releases/download/${GITHUB_LATEST_VERSION}/${GITHUB_FILE}"

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_TMP=${SANDBOX_CONF_HOME:-/tmp}

# install/update the local binary to the latest version
rm -f $SANDBOX_CONF_HOME/bin/lazydocker
export LDDIST=$SANDBOX_TMP/lazydocker.tar.gz
curl -s -L -o $LDDIST $GITHUB_URL
tar xzf $LDDIST lazydocker
mv lazydocker $SANDBOX_CONF_HOME/bin/lazydocker
rm $LDDIST