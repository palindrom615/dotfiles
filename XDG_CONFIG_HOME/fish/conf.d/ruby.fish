if command -sq ruby && command -sq gem
	set -x PATH $PATH (ruby -r rubygems -e 'puts Gem.user_dir')/bin
end
