INSTALL=$1
SHELL_NAME="$(basename "$SHELL")"

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add gcloud
    asdf install gcloud "${GCLOUD_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions gcloud | head -n 1 | awk '{print $2}')
    asdf global gcloud "${VERSION}"
  fi

# install via homebrew
else
  [ -n "$INSTALL" ] && brew cask install "google-cloud-sdk"
  INSTALL_DIR="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"

  if [ -d "$INSTALL_DIR" ]; then
     source "$INSTALL_DIR/path.$SHELL_NAME.inc"
     source "$INSTALL_DIR/completion.$SHELL_NAME.inc"
  fi
fi

export CLOUDSDK_PYTHON=python
