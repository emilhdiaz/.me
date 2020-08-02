INSTALL=$1

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

  if [ -n "$BASH_VERSION" ]; then
     source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
     source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
  fi

  if [ -n "$ZSH_VERSION" ]; then
    source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
  fi
fi

export CLOUDSDK_PYTHON=python
