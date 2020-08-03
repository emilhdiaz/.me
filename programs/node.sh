INSTALL=$1
SHELL_NAME="$(basename "$SHELL")"

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add nodejs
    asdf install nodejs "${NODE_INSTALL_VERSION:-latest}"
    bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
    VERSION=$(asdf shim-versions node | head -n 1 | awk '{print $2}')
    asdf global nodejs "${VERSION}"
  fi

# install via homebrew & nvm
else
  [ -n "$INSTALL" ] && brew install "nvm"
  INSTALL_DIR="$(brew --prefix nvm)"

  if [ -f "$INSTALL_DIR" ]; then
    export NVM_DIR="$HOME/.nvm"
    export PATH="./node_modules/.bin:$PATH" # for quick access to node packages
    source "$INSTALL_DIR/nvm.sh"
    source "$INSTALL_DIR/etc/bash_completion.d/nvm"
  fi

  [ -n "$INSTALL" ] && nvm install node --lts
fi
