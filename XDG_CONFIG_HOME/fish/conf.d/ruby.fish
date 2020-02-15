if type -q ruby; and type -q gem
	add_bin_paths (ruby -r rubygems -e 'puts Gem.user_dir')
end
