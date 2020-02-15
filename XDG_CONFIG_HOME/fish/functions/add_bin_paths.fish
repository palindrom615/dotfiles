function add_bin_paths
	for dir in $argv
		if test -d $dir
			add_path $dir/bin
		end
	end
end