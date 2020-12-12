#!/usr/bin/env bash

export SANDBOX_POLYLANG_HOME=${SANDBOX_POLYLANG_HOME:-$SANDBOX_CONF_HOME/lang}
export NVM_DIR="$SANDBOX_POLYLANG_HOME/nvm"

echo "Check Node Version Manager install"
mkdir -p $NVM_DIR # needed by install.sh since we're not using the default
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source $NVM_DIR/nvm.sh
nvm --version

echo "Install NodeJS LTS version for ESLint"
nvm install --lts
nvm use --lts
node -v
npm -v

echo "Install ESlint, Typescript as peer dependency for ESLint"
npm install -g typescript
npm install -g eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
