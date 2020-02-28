#!/usr/bin/env sh

# macOS does not have coreutils out-of-box
if ! type realpath > /dev/null; then
	realpath() {
		[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
	}
fi

mkdir -p $HOME/Pictures

wget -bq "https://source.unsplash.com/featured/1920x1440/?wallpaper,nature" -O $HOME/Pictures/wp.jpg

REPODIR=$(realpath $(dirname "$0"))

ln -s $REPODIR/XDG_CONFIG_HOME/* $HOME/.config

#link whole files include name of which starts with dot
ln -s $REPODIR/HOME/.[!.]* $HOME

