INSTALL=$1
SHELL_NAME="$(basename "$SHELL")"

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add golang
    asdf install golang "${GOLANG_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions go | head -n 1 | awk '{print $2}')
    asdf global golang "${VERSION}"
  fi

# install via homebrew
else
  [ -n "$INSTALL" ] && brew install go
  INSTALL_DIR="$(brew --prefix golang)"

  if [ -d "$INSTALL_DIR" ]; then
    export GOPATH="${HOME}/.go"
    export GOROOT="$INSTALL_DIR/libexec"
    export PATH="${GOPATH}/bin:${GOROOT}/bin:$PATH"
  fi
fi

# install plugins
if [ -n "$INSTALL" ]; then
  go get golang.org/x/tools/cmd/godoc
  go get -u golang.org/x/lint/golint
#  go get github.com/golang/lint/golint
fi
