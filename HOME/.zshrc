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

