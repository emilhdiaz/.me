#!/usr/bin/env zsh

VERSION=$1

asdf_install_or_upgrade nodejs "${VERSION}"
npm install -g npm > /dev/null 2>&1
