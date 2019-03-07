#!/usr/bin/env sh

# macOS does not have coreutils out-of-box
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

REPODIR=$(realpath $(dirname "$0"))

ln -s $REPODIR/XDG_CONFIG_HOME/* $HOME/.config

#link whole files include name of which starts with dot
ln -s $REPODIR/HOME/.[!.]* $HOME

