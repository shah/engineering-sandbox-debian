#!/usr/bin/env bash

echo "Check Node Version Manager install"
[[ -f $HOME/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh
nvm --version

echo "Install NodeJS LTS version for ESLint"
nvm install --lts
nvm use --lts
node -v
npm -v

echo "Install ESlint, Typescript as peer dependency for ESLint"
npm install -g typescript
npm install -g eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
