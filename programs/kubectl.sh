INSTALL=$1
SHELL_NAME="$(basename "$SHELL")"

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add kubectl
    asdf install kubectl "${KUBECTL_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions kubectl | head -n 1 | awk '{print $2}')
    asdf global kubectl "${VERSION}"
  fi

# install via homebrew
else
  [ -n "$INSTALL" ] && brew install "kubectl"

  [ -x "$(command -v kubectl)" ] && source <(kubectl completion "$SHELL_NAME");
fi
