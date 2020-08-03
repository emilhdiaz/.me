INSTALL=$1
SHELL_NAME="$(basename "$SHELL")"

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add helm
    asdf install helm "${HELM_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions helm | head -n 1 | awk '{print $2}')
    asdf global helm "${VERSION}"
  fi

# install via homebrew
else
  [ -n "$INSTALL" ] && brew install "helm"

  [ -x "$(command -v helm)" ] && source <(helm completion "$SHELL_NAME");
fi
