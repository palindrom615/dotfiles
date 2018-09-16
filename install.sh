#!/usr/bin/env sh

BASEDIR=$(realpath $(dirname "$0"))

ln -s $BASEDIR/XDG_CONFIG_HOME/* $HOME/.config
