#!/bin/bash
set -eu

DIR="$(pwd)"

cd home

for path in `find . -type f | grep -v -i '.ds_store'`; do 
  if [ -e "$HOME/$path" ]; then
    if [ "$(realpath "$HOME/$path")" != "$(realpath "$(pwd)/$path")" ]; then
      echo "error: invalid file found!: $HOME/$path" 1>&2
      continue;
    else
      continue;
    fi
  fi

  mkdir -p "$(dirname "$HOME/$path")"
  ln -s "$(pwd)/$path" "$HOME/$path"
done

cd $DIR

brew bundle
