#!/usr/bin/env zsh

INSTALLERS_DIR="$( cd "$( dirname "${(%):-%x}" )" >/dev/null 2>&1 && pwd )"
source ${INSTALLERS_DIR}/../common.sh

brew_install_or_upgrade() {
  local PROGRAM=$1 && shift
  local DESIRED_VERSION=${1:-}
  local CURRENT_VERSION=$(brew list --versions ${PROGRAM} | cut -d' ' -f2 | head)

  require_tool brew

  # check if brew has formula installed
  if [ -z "${CURRENT_VERSION}" ]; then

    # let's try to install via brew
    log_info "${PROGRAM} is not installed, installing..."
    if [ ! -z "${DESIRED_VERSION}" ]; then
      brew install ${PROGRAM}@${DESIRED_VERSION}
    else
      brew install ${PROGRAM}
    fi

    # it's possible the brew formula was keg-only, if so try to link
    if ! [ -x "$(command -v ${PROGRAM})" ]; then
      brew link --force ${PROGRAM}@${DESIRED_VERSION}
    fi
    log_info "${PROGRAM}@${DESIRED_VERSION} installed."

  # check if we need to upgrade
  elif [ ! -z "${DESIRED_VERSION}" ] && [ $(version ${DESIRED_VERSION}) -gt $(version ${CURRENT_VERSION}) ]; then
    # let's try to upgrade via brew
    log_info "${PROGRAM}@${CURRENT_VERSION} version is older, upgrading to ${DESIRED_VERSION}."
    brew upgrade ${PROGRAM}@${DESIRED_VERSION}
    brew link --force ${PROGRAM}@${DESIRED_VERSION}
    log_info "${PROGRAM} upgraded to version ${DESIRED_VERSION}."

  elif [ ! -z "${DESIRED_VERSION}" ] && [ $(version ${DESIRED_VERSION}) -lt $(version ${CURRENT_VERSION}) ]; then
    log_info "${PROGRAM}@${CURRENT_VERSION} version is newer, aborting..."
    return 1

  else
    log_info "${PROGRAM}@${DESIRED_VERSION} is already installed."
  fi
}



install_darwin_helm() {
  brew_install_or_upgrade helm@2
  helm init --client-only
  helm_plugin_install_or_upgrade helm-diff https://github.com/databus23
  helm_plugin_install_or_upgrade helm-s3.git https://github.com/hypnoglow
}

install_darwin_ansible() {
  local PROGRAM='ansile'
  local VERSION=$1 && shift
  require_tool python
  log_info "Installing ${PROGRAM}@${VERSION}..."
  brew_install_or_upgrade gnu-tar
  pip_install_or_upgrade ansible "${VERSION}"
  log_info "${PROGRAM}@${VERSION} is installed."
}