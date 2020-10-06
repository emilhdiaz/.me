#!/usr/bin/env zsh

VERSION=$1

require_tool tfenv

tfenv install "${VERSION}"
tfenv use "${VERSION}"
