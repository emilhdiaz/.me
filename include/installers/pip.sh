#!/usr/bin/env zsh

INSTALLERS_DIR="$( cd "$( dirname "${(%):-%x}" )" >/dev/null 2>&1 && pwd )"
source ${INSTALLERS_DIR}/../common.sh

pip_install_or_upgrade() {
  local PROGRAM=$1 && shift
  local DESIRED_VERSION=${1:-}
  local CURRENT_VERSION=$(pip3 show ${PROGRAM} | grep Version: | cut -d' ' -f2)

  require_tool pip3

  # check if pip has package installed
  if [ -z "${CURRENT_VERSION}" ]; then
    # let's try to install via pip
    log_info "${PROGRAM} is not installed, installing..."

    if [ ! -z "${DESIRED_VERSION}" ]; then
      pip3 install -q ${PROGRAM}==${DESIRED_VERSION}
    else
      pip3 install -q ${PROGRAM}
    fi

    log_info "${PROGRAM}@${DESIRED_VERSION} installed."

  # check if we need to upgrade
  elif [ ! -z "${DESIRED_VERSION}" ] && [ $(version ${DESIRED_VERSION}) -gt $(version ${CURRENT_VERSION}) ]; then
    # let's try to upgrade via brew
    log_info "${PROGRAM}@${CURRENT_VERSION} version is older, upgrading to ${DESIRED_VERSION}."
    pip3 install -q ${PROGRAM}==${DESIRED_VERSION}
    log_info "${PROGRAM} upgraded to version ${DESIRED_VERSION}."

  elif [ ! -z "${DESIRED_VERSION}" ] && [ $(version ${DESIRED_VERSION}) -lt $(version ${CURRENT_VERSION}) ]; then
    log_warn "${PROGRAM}@${CURRENT_VERSION} version is newer, aborting..."
    return 1

  else
    log_info "${PROGRAM}@${DESIRED_VERSION} is already installed."
  fi
}