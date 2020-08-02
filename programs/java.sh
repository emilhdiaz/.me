INSTALL=$1

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add java
    asdf install java "${JAVA_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions java | head -n 1 | awk '{print $2}')
    asdf global java "${VERSION}"
  fi

# install via homebrew
else
  [ -n "$INSTALL" ] && brew cask install "java"

  export JAVA_HOME="$(/usr/libexec/java_home -V)"
fi

## Activate JAVA version
#if [ -f "$HOME/.asdf/plugins/java/set-java-home.zsh" ]; then
#    source "$HOME/.asdf/plugins/java/set-java-home.zsh"
#fi
