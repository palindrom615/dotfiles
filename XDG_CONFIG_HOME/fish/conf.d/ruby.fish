if command -sq ruby and command -sq gem
	set -x PATH $PATH (ruby -r rubygems -e 'puts Gem.user_dir')/bin
end
