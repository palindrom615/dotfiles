if command_exist ruby && command_exist gem
	add_path (ruby -r rubygems -e 'puts Gem.user_dir')/bin
end
