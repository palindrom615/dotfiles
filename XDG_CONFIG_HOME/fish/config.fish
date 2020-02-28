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

if status --is-login
	for file in /etc/profile.d/*.sh
		bass source $file
	end
end

## user side executables
add_bin_paths $HOME/.deno \
	$HOME/.local/share/flutter \
	$HOME/.local/share/google-cloud-sdk \
	$HOME/.cargo

## go settings
add_bin_paths $HOME/go $HOME/.local/share/go
if type -q go
	set -x GO111MODULE on
end

## nodejs settings
if type -q npm
	add_bin_paths (npm get prefix)
end

if type -q yarn
	add_bin_paths (yarn config get prefix)
end

## python settings
if type -q python
	add_bin_paths (python -m site --user-base)
end

## ruby settings
if type -q ruby; and type -q gem
	add_bin_paths (ruby -r rubygems -e 'puts Gem.user_dir')
end

## conda settings
if test -d $HOME/.local/share/anaconda3
	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
	eval $HOME/.local/share/anaconda3/bin/conda "shell.fish" "hook" $argv | source
	# <<< conda initialize <<<
end

## snap settings
if test -d /var/lib/snapd/snap
	add_bin_paths /var/lib/snapd/snap
end

## own alias settings
alias l=(fallback_command exa ls)
alias c=(fallback_command bat cat)
alias v=(fallback_command nvim vim vi)
alias k='kubectl'
alias d='docker'

if type -q starship
	eval (starship init fish)
end
