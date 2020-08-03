INSTALL=$1
SHELL_NAME="$(basename "$SHELL")"

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add java
    asdf install java "${JAVA_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions java | head -n 1 | awk '{print $2}')
    asdf global java "${VERSION}"
  fi

  source "$HOME/.asdf/plugins/java/set-java-home.$SHELL_NAME"

# install via homebrew
else
  [ -n "$INSTALL" ] && brew cask install "java"

  export JAVA_HOME="$(/usr/libexec/java_home -V)"
fi
