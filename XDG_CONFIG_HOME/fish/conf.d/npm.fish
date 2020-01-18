if command_exist npm
	add_path (npm get prefix)/bin
end

if command_exist yarn
	add_path (yarn config get prefix)/bin
end

