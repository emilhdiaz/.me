INSTALL=$1
SHELL_NAME="$(basename "$SHELL")"

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add direnv
    asdf install direnv "${DIRENV_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions direnv | head -n 1 | awk '{print $2}')
    asdf global direnv "${VERSION}"
  fi

# install via homebrew
else
  [ -n "$INSTALL" ] && brew install "direnv"

  [ -x "$(command -v direnv)" ] && source <(direnv hook "$SHELL_NAME");
fi
