#
# ~/.bash_profile
#
if ! (declare -f -F pathmunge > /dev/null ); then
	pathmunge () {
		if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
			if [ "$2" = "after" ] ; then
				PATH=$PATH:$1
			else
				PATH=$1:$PATH
			fi
		fi
	}
fi

fallback_commands () {
	for command in "$@"
	do
		if command -v $command &> /dev/null; then
			echo $command
			break
		fi
	done
}

export EDITOR="$(fallback_commands nvim vim vi)"

# rust
pathmunge $HOME/.cargo/bin

# deno
pathmunge $HOME/.deno/bin

# flutter
pathmunge $HOME/.local/share/flutter/bin

# gcloud sdk
pathmunge $HOME/.local/share/google-cloud-sdk/bin

# golang
pathmunge $HOME/go/bin
pathmunge $HOME/.local/share/go/bin
export GO111MODULE=on

# snapcraft
pathmunge /var/lib/snapd/snap/bin

# node
if command -v npm &> /dev/null; then
	pathmunge "$(npm get prefix)/bin"
fi
if command -v yarn &> /dev/null; then
	pathmunge "$(yarn config get prefix)/bin"
fi

# python
if command -v python &> /dev/null; then
	pathmunge "$(python -m site --user-base)/bin"
fi

# ruby
if command -v ruby && command -v gem &> /dev/null; then
	pathmunge "$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
fi

# ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
if [[ -x "$(command -v ibus-daemon)" ]]; then
	ibus-daemon -drx
fi

# wayland
export _JAVA_AWT_WM_NONREPARENTING=1

if [[ -x "$(command -v sway)" ]] && [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec sway
fi
