if command_exist ruby && command_exist gem
	set -x PATH (ruby -r rubygems -e 'puts Gem.user_dir')/bin $PATH
end
