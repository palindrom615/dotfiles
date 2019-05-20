function command_exist
	return command -v $argv[1] > /dev/null 2>&1
end
