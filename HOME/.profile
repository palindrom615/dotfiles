#
# ~/.profile
#
if ! (declare -f -F pathmunge > /dev/null ); then
	pathmunge () {
		if (test -d "$1") && ! (echo $PATH | /bin/egrep -q "(^|:)$1($|:)") &> /dev/null; then
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
	alias python="$(fallback_commands python3 python)"
	alias pip="$(fallback_commands pip3 pip)"
	pathmunge "$(python -m site --user-base)/bin"
fi

# ruby
if command -v ruby &> /dev/null && command -v gem &> /dev/null; then
	pathmunge "$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
fi

# sdkman
if command -v sdk &> /dev/null; then
	eval `sdk export`
fi

if command -v rmtrash &> /dev/null; then
	alias rm="echo Use 'del', or the full path i.e. '/bin/rm'"
	alias trash="rmtrash"
	alias del"rmtrash"
fi

# Linux
if [ $(uname) == "Linux" ]; then

	# nimf
	export GTK_IM_MODULE=nimf
	export XMODIFIERS=@im=nimf
	export QT_IM_MODULE=nimf
	if [[ -x "$(command -v nimf)" ]]; then
		nimf
	fi

	# wayland
	export _JAVA_AWT_WM_NONREPARENTING=1
	export MOZ_ENABLE_WAYLAND=1

	if [[ -x "$(command -v sway)" ]] && [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
		exec sway >> ~/.log/sway.log 2>&1
	fi
fi

# macOS
if [ $(uname) == "Darwin" ]; then
	pathmunge "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
	pathmunge "/Applications/Sublime Text.app/Contents/SharedSupport/bin"
fi
