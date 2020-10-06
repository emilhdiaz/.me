#!/usr/bin/env zsh

VERSION=$1

asdf_install_or_upgrade helmsman "${VERSION}" --plugin https://github.com/jkrukoff-cb/asdf-helmsman.git
