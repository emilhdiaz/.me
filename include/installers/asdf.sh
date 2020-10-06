#!/usr/bin/env zsh

INSTALLERS_DIR="$( cd "$( dirname "${(%):-%x}" )" >/dev/null 2>&1 && pwd )"
source ${INSTALLERS_DIR}/../common.sh

asdf_install_or_upgrade() {
  local PROGRAM=$1 && shift
  local DESIRED_VERSION=${1:-latest}
  local CURRENT_VERSION=$(asdf current ${PROGRAM} 2> /dev/null | tr -s " "| cut -d' ' -f2)
  local PLUGIN=$(parse_long_opt 'plugin' '' "$@")

  require_tool asdf

  # check if asdf has plugin installed
  if ! (asdf plugin list | grep ${PROGRAM} > /dev/null 2>&1); then
    log_info "Installing plugin repository..."
    asdf plugin add "${PROGRAM}" "${PLUGIN}"
  fi

  # resolve "latest" version
  if [[ "$DESIRED_VERSION" == "latest" ]]; then
    DESIRED_VERSION=$(asdf latest $PROGRAM)
  fi

#  echo $DESIRED_VERSION
#  echo $CURRENT_VERSION

  # check if asdf has package installed
  if [ -z "${CURRENT_VERSION}" ]; then
    # let's try to install via asdf
    log_info "${PROGRAM} is not installed, installing..."
    asdf install "${PROGRAM}" "${DESIRED_VERSION}"
    log_info "${PROGRAM}@${DESIRED_VERSION} installed."

  # check if we need to upgrade
  elif [ ! -z "${DESIRED_VERSION}" ] && [ $(version ${DESIRED_VERSION}) -gt $(version ${CURRENT_VERSION}) ]; then
    # let's try to upgrade via brew
    log_info "${PROGRAM}@${CURRENT_VERSION} version is older, upgrading to ${DESIRED_VERSION}."
    asdf install "${PROGRAM}" "${DESIRED_VERSION}"
    log_info "${PROGRAM} upgraded to version ${DESIRED_VERSION}."

  elif [ ! -z "${DESIRED_VERSION}" ] && [ $(version ${DESIRED_VERSION}) -lt $(version ${CURRENT_VERSION}) ]; then
    log_warn "${PROGRAM}@${CURRENT_VERSION} version is newer, aborting..."
    return 1

  else
    log_info "${PROGRAM}@${DESIRED_VERSION} is already installed."
  fi

  asdf global "${PROGRAM}" "${DESIRED_VERSION}"
}
