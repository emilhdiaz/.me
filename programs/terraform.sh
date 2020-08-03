INSTALL=$1
SHELL_NAME="$(basename "$SHELL")"

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add terraform
    asdf install terraform "${TERRAFORM_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions terraform | head -n 1 | awk '{print $2}')
    asdf global terraform "${VERSION}"
  fi

# install via homebrew
else
  [ -n "$INSTALL" ] && brew install "terraform"

  [ -x "$(command -v terraform)" ] && complete -o nospace -C /usr/local/bin/terraform terraform;
fi
