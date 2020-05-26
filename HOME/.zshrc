export KEYTIMEOUT=1
bindkey -v

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"

zplug load

if command -v starship &> /dev/null; then
	eval "$(starship init zsh)"
fi

if command -v thefuck &> /dev/null; then
	eval "$(thefuck --alias)"
fi

[ -s "/Users/haley/.scm_breeze/scm_breeze.sh" ] && source "/Users/haley/.scm_breeze/scm_breeze.sh"

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
alias d=docker
alias k="kubectl"

