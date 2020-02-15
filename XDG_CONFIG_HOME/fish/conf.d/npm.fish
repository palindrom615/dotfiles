if command_exist npm
	add_bin_paths (npm get prefix)
end

if command_exist yarn
	add_bin_paths (yarn config get prefix)
end

