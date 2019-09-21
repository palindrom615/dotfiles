alias dropbox "/home/palindrom615/dropbox.py"

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

eval (starship init fish)

