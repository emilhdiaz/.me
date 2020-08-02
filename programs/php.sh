INSTALL=$1

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add php
    asdf install php "${PHP_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions php | head -n 1 | awk '{print $2}')
    asdf global php "${VERSION}"
  fi

# install via homebrew & nvm
else
  [ -n "$INSTALL" ] && brew install "php" "composer"

  export PATH="$HOME/.composer/vendor/bin:$PATH"
fi
