#!/usr/bin/env zsh

INSTALLERS_DIR="$( cd "$( dirname "${(%):-%x}" )" >/dev/null 2>&1 && pwd )"
source ${INSTALLERS_DIR}/../common.sh

helm_plugin_install_or_upgrade() {
  local PLUGIN=$1 && shift
  local REPO=${1:-}

  require_tool helm

  # check if helm has plugin installed
  if ! (helm plugin list | grep ${PLUGIN} > /dev/null 2>&1); then
    # let's try to install via pip
    log_info "${PLUGIN} is not installed, installing..."
    helm plugin install ${REPO}/${PLUGIN}

  else
    # let's try to install via pip
    log_info "${PLUGIN} already installed, attempting to upgrade..."
    helm plugin update ${PLUGIN}
  fi
}
