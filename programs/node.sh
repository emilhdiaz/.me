INSTALL=$1

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add nodejs
    asdf install nodejs "${NODE_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions node | head -n 1 | awk '{print $2}')
    asdf global nodejs "${VERSION}"
  fi

# install via homebrew & nvm
else
  [ -n "$INSTALL" ] && brew install "nvm"

  export NVM_DIR="$HOME/.nvm"
  export PATH="./node_modules/.bin:$PATH" # for quick access to node packages
  source "$(brew --prefix nvm)/nvm.sh"
  source "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

  [ -n "$INSTALL" ] && nvm install node --lts
fi
