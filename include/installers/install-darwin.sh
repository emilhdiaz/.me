#!/usr/bin/env zsh

INSTALLERS_DIR="$( cd "$( dirname "${(%):-%x}" )" >/dev/null 2>&1 && pwd )"
source ${INSTALLERS_DIR}/../common.sh
source ${INSTALLERS_DIR}/asdf.sh
source ${INSTALLERS_DIR}/brew.sh
source ${INSTALLERS_DIR}/helm.sh
source ${INSTALLERS_DIR}/npm.sh
source ${INSTALLERS_DIR}/pip.sh

darwin_install_or_upgrade() {
  local PACKAGE_MANAGER=$1 && shift
  local PROGRAM=$1 && shift
  local VERSION=${1:-}

  log_info "Installing or updating ${YELLOW}${PROGRAM}@${VERSION}${NC} via ${PACKAGE_MANAGER}."
  if [ -n "${DRY_RUN}" ]; then
    return
  fi

  local INSTALL_SCRIPT="${_DIR}/../../programs/${PACKAGE_MANAGER}/$(echo ${PROGRAM} | sed -e 's/\//_/')-install.sh"

  if [ -f "${INSTALL_SCRIPT}" ]; then
    $SHELL "${INSTALL_SCRIPT}" "${VERSION}"
    return
  fi

  # install via asdf
  if [[ "$PACKAGE_MANAGER" == "asdf" ]]; then
    asdf_install_or_upgrade "${PROGRAM}" "${VERSION}"

  # install via homebrew
  elif [[ "$PACKAGE_MANAGER" == "homebrew" ]]; then
    brew_install_or_upgrade "${PROGRAM}" "${VERSION}"

  # install via pip
  elif [[ "$PACKAGE_MANAGER" == "pip" ]]; then
    pip_install_or_upgrade "${PROGRAM}" "${VERSION}"

  # install via npm
  elif [[ "$PACKAGE_MANAGER" == "npm" ]]; then
    npm_install_or_upgrade "${PROGRAM}" "${VERSION}"

  # install via helm
  elif [[ "$PACKAGE_MANAGER" == "helm" ]]; then
    helm_install_or_upgrade "${PROGRAM}" "${VERSION}"

  # package manager not supported
  else
    log_error "The '$PACKAGE_MANAGER' package manager is not supported on darwin" && return 1
  fi
}
