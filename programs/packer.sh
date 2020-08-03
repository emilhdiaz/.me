INSTALL=$1
SHELL_NAME="$(basename "$SHELL")"

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add packer
    asdf install packer "${PACKER_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions packer | head -n 1 | awk '{print $2}')
    asdf global packer "${VERSION}"
  fi

# install via homebrew
else
  [ -n "$INSTALL" ] && brew install "packer"

  [ -x "$(command -v packer)" ] && complete -o nospace -C /usr/local/bin/packer packer;
fi
