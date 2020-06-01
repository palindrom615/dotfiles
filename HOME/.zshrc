### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions
zinit light scmbreeze/scm_breeze
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

KEYTIMEOUT=1
bindkey -e

SAVEHIST=10000
HISTFILE=~/.zsh_history

function fallback_command {
	for com in $argv; do
		if command -v $com &> /dev/null; then
			echo "$com"
			break
		fi;
	done	
}

alias l="$(fallback_command exa ls)"
alias c="$(fallback_command bat cat)"
alias v="$(fallback_command nvim vim vi)"
alias d="docker"


if command -v starship &> /dev/null; then
	eval "$(starship init zsh)"
fi

if command -v thefuck &> /dev/null; then
	eval "$(thefuck --alias)"
fi

