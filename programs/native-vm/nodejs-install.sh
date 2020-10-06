#!/usr/bin/env zsh

VERSION=$1

require_tool nvm

nvm install "${VERSION}"
npm config set user 0
npm config set unsafe-perm true
npm install -g npm
