#!/usr/bin/env zsh

VERSION=$1
export CPPFLAGS="-I$(brew --prefix zlib)/include"

require_tool pyenv

pyenv install -v -s "${VERSION}"
pyenv global "${VERSION}"
pip3 install --upgrade pip
