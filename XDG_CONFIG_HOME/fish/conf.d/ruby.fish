if command_exist ruby && command_exist gem
	add_bin_paths (ruby -r rubygems -e 'puts Gem.user_dir')
end
