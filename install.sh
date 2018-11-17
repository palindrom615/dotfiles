#!/usr/bin/env sh

REPODIR=$(realpath $(dirname "$0"))

ln -s $REPODIR/XDG_CONFIG_HOME/* $HOME/.config
ln -s $REPODIR/HOME/.[!.]* $HOME

