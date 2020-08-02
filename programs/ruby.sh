INSTALL=$1

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add ruby
    asdf install ruby "${RUBY_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions ruby | head -n 1 | awk '{print $2}')
    asdf global ruby "${VERSION}"
  fi

# install via homebrew & nvm
else
  [ -n "$INSTALL" ] && brew install "ruby"
fi
