#!/usr/bin/env zsh

_DIR="$( cd "$( dirname "${(%):-%x}" )" >/dev/null 2>&1 && pwd )"
source ${_DIR}/include/common.sh
source ${_DIR}/include/installers/install-darwin.sh
source ${_DIR}/include/installers/asdf.sh
source ${_DIR}/include/installers/brew.sh

install_from_config() {
  local CONFIG=$1
  local LENGTH
  local PROGRAM
  local INSTALLER
  local VERSION
  LENGTH=$(yq r "${CONFIG}" --length programs)


  for ((i=0; i<=LENGTH-1; i++)); do
    PROGRAM=$(yq r "${CONFIG}" "programs[$i].name")
    INSTALLER=$(yq r "${CONFIG}" "programs[$i].installer")
    VERSION=$(yq r "${CONFIG}" "programs[$i].version")

    log_info "Found ${INSTALLER}:${PROGRAM}@${VERSION}"

    install_program "${INSTALLER}" "${PROGRAM}" "${VERSION}"
    echo "\n"
  done
}

install_program() {
  local PACKAGE_MANAGER=$1 && shift
  local PROGRAM=$1 && shift
  local VERSION=${1:-}

  if [[ "$OSTYPE" == "darwin"* ]]; then
    darwin_install_or_upgrade "${PACKAGE_MANAGER}" "${PROGRAM}" "${VERSION}"
  else
    log_error "The '$OSTYPE' operating system is not supported" && return 1
  fi
}

install_from_config "program_config.yml"
