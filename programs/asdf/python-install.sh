#!/usr/bin/env zsh

VERSION=$1

asdf_install_or_upgrade python "${VERSION}"
pip3 install --upgrade pip > /dev/null 2>&1
