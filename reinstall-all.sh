#!/bin/sh
SCRIPTDIR=$(cd -P $(dirname $0) && pwd -P)
cd "$SCRIPTDIR"
brew remove --force $(brew list) --ignore-dependencies
brew bundle
