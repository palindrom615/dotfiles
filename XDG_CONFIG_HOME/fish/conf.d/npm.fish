if type -q npm
	add_bin_paths (npm get prefix)
end

if type -q yarn
	add_bin_paths (yarn config get prefix)
end

