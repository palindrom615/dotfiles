# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node \
    scmbreeze/scm_breeze

export FZF_BASE="$HOME/.fzf"
### End of Zinit's installer chunk
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
      agkozak/zsh-z
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
zinit snippet OMZ::plugins/fzf/fzf.plugin.zsh


zinit ice depth=1; zinit light romkatv/powerlevel10k

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
alias v="$(fallback_command nvim vim vi)"
alias d="docker"


if command -v thefuck &> /dev/null; then
	eval "$(thefuck --alias)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/haley/.sdkman"
[[ -s "/Users/haley/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/haley/.sdkman/bin/sdkman-init.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U select-word-style
select-word-style bash

export WORDCHARS='.-'

