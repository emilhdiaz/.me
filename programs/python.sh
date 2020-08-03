INSTALL=$1
SHELL_NAME="$(basename "$SHELL")"

# install via asdf
if type "asdf" > /dev/null; then
  if [ -n "$INSTALL" ]; then
    asdf plugin add python
    asdf install python "${PYTHON_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions python | head -n 1 | awk '{print $2}')
    asdf global python "${VERSION}"

    asdf plugin add poetry
    asdf install poetry "${POETRY_INSTALL_VERSION:-latest}"
    VERSION=$(asdf shim-versions poetry | head -n 1 | awk '{print $2}')
    asdf global poetry "${VERSION}"
  fi

  export POETRY_HOME="$HOME/.asdf/installs/poetry/1.0.10"
  export PATH="${POETRY_HOME}/bin:$PATH"

# install via homebrew & pyenv
else
  [ -n "$INSTALL" ] && brew install "pyenv" "pyenv-virtualenv" "poetry"

  export POETRY_HOME="$HOME/.poetry"
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${POETRY_HOME}/bin:$PATH"
  eval "$(pyenv init -)";
  eval "$(pyenv virtualenv-init -)";

  [ -n "$INSTALL" ] && pyenv install 3.8.5
fi
