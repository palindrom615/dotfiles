set fish_term24bit 1

## fisher install
## https://github.com/jorgebucaran/fisher
if not functions -q fisher
	set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
	curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
	fish -c fisher
end

## fisher path qurantine
set -g fisher_path $HOME/.config/fish/fisher
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

# profiles
if status --is-login
	for file in /etc/profile.d/*.sh
		bass source $file
	end
	bass source $HOME/.bash_profile
end


# conda
if test -d $HOME/.local/share/anaconda3
	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
	eval $HOME/.local/share/anaconda3/bin/conda "shell.fish" "hook" $argv | source
	# <<< conda initialize <<<
end

# alias
alias l=(fallback_command exa ls)
alias c=(fallback_command bat cat)
alias v=(fallback_command nvim vim vi)
alias k='kubectl'
alias d='docker'

if type -q starship
	eval (starship init fish)
end
